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
    //private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Track>
    private var tracks = [Track]()
    //private var currentSnapshot: Snapshot?
    private var nextUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        configureDataSource()
    }
    
    private func setupView() {
        collectionView.register(UINib(nibName: TrackGridCell.identifier, bundle: nil),forCellWithReuseIdentifier: TrackGridCell.identifier)
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
                print(response.tracks.toJSON())
                self.nextUrl = response.nextUrl
                DispatchQueue.main.async {
                    self.tracks.append(contentsOf: response.tracks)
                    self.handle(response.tracks)
                }
            }
        }
    }
    
    private func requestTrackNextPage() {
        HttpRequests.request(request: GetListTrackNextPageAPI(url: self.nextUrl)) { (result, response) in
            if result {
                print(response.tracks.toJSON())
                self.nextUrl = response.nextUrl
                DispatchQueue.main.async {
                    self.tracks.append(contentsOf: response.tracks)
                    self.handle(self.tracks)
                }
            }
        }
    }
    
    private func configureDataSource() {
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == tracks.count - 5 {
            self.requestTrackNextPage()
        }
    }
}
