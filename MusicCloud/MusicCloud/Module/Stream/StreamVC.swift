//
//  StreamVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 18/11/2020.
//

import UIKit

final class StreamVC: UIViewController {
    
    enum Section {
        case main
    }

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Track>! = nil
    private var tracks = [Track]()
    private var nextUrl = ""
    private var isLoading: Bool = false
    private var gridStyle: Bool = false
    var onClickSong: (() -> Void)?
    
    private lazy var gridButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3.fill"),
                                     style: .plain, target: self, action: #selector(addTapped))
        return button
    }()
    
    private lazy var listButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "music.note.list"),
                                     style: .plain, target: self, action: #selector(addTapped))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        configureDataSource()
    }
    
    private func setupView() {
        collectionView.register(UINib(nibName: TrackGridCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: TrackGridCell.identifier)
        collectionView.register(UINib(nibName: TrackCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: TrackCell.identifier)
        collectionView.register(LoadingFooterCell.self,
                                forSupplementaryViewOfKind: "loading-footer",
                                withReuseIdentifier: LoadingFooterCell.reuseIdentifier)
        collectionView.collectionViewLayout = self.gridStyle ? CollectionViewStyle.grid.layout() : CollectionViewStyle.tracklist.layout()
        collectionView.delegate = self
    }

    private func setupNavBar() {
        self.navigationItem.title = "Stream"
        self.navigationItem.leftBarButtonItem = listButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"),
                                                                 style: .plain, target: self, action: #selector(searchTapped))
    }
    
    @objc private func addTapped() {
        requestTrack()
        onClickSong?()
    }
    
    @objc private func searchTapped(){
        self.gridStyle.toggle()
        self.navigationItem.leftBarButtonItem = gridStyle ?  gridButton : listButton
        configureDataSource()
    }
    
    private func requestTrack() {
        HttpRequests.request(request: GetListTrackAPI(limit: 20)) { (result, response) in
            if result {
                self.nextUrl = response.nextUrl
                DispatchQueue.main.async {
                    self.tracks.append(contentsOf: response.tracks)
                    self.handle(response.tracks)
                }
            }
        }
    }
    
    private func requestTrackNextPage() -> Bool {
        if isLoading {
            return false
        }
        isLoading = true
        HttpRequests.request(request: GetListTrackNextPageAPI(url: self.nextUrl)) { [weak self] (result, response) in
            guard let weakSelf = self else { return }
            if result {
                weakSelf.nextUrl = response.nextUrl
                DispatchQueue.main.async {
                    weakSelf.tracks.append(contentsOf: response.tracks)
                    weakSelf.handle(weakSelf.tracks)
                }
            }
            weakSelf.isLoading = false
        }
        return true
    }
    
    private func configureDataSource() {
        // data source for cell
        dataSource = UICollectionViewDiffableDataSource<Section, Track>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, track: Track?) -> UICollectionViewCell? in
            
            guard let gridCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrackGridCell.identifier,
                    for: indexPath) as? TrackGridCell else { fatalError("Cannot create new cell")}
            
            guard let listCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrackCell.identifier,
                    for: indexPath) as? TrackCell else { fatalError("Cannot create new cell")}
            
            let cell = self.gridStyle ? gridCell : listCell
            
            if let track = track {
                self.gridStyle ? gridCell.setupCell(track: track) : listCell.setupCell(track: track)
            }
            return cell
        }
        // data source for footer loading cell
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  kind: String, indexPath: IndexPath) ->UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: LoadingFooterCell.reuseIdentifier,
                    for: indexPath) as? LoadingFooterCell else { fatalError("Cannot create new supplementary") }
            self.isLoading ? supplementaryView.showLoadingIndicator() : supplementaryView.stopLoadingIndicator()
            return supplementaryView
        }
    }
    
    private func handle(_ tracks: [Track]) {
        // initialize data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Track>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tracks)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension StreamVC: UICollectionViewDelegate {
    // perform auto load more
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == tracks.count - 5, !nextUrl.isEmpty, !isLoading  {
            _ = self.requestTrackNextPage()
        }
    }
}
