//
//  StreamVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 18/11/2020.
//

import UIKit

class StreamVC: UIViewController {
    
    enum Section {
        case main
    }

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Track>! = nil
    private var tracks = [Track]()
    private var nextUrl = ""
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        configureDataSource()
    }
    
    private func setupView() {
        collectionView.register(UINib(nibName: TrackGridCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: TrackGridCell.identifier)
        collectionView.register(LoadingFooterCell.self,
                                forSupplementaryViewOfKind: "loading-footer",
                                withReuseIdentifier: LoadingFooterCell.reuseIdentifier)
        collectionView.collectionViewLayout = CollectionViewStyle.grid.layout()
        collectionView.delegate = self
    }

    private func setupNavBar() {
        self.navigationItem.title = "Stream"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        requestTrack()
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
            
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrackGridCell.identifier,
                    for: indexPath) as? TrackGridCell
            else { fatalError("Cannot create new cell")}
            
            if let track = track {
                cell.setupCell(track: track)
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
