//
//  PlayerVC.swift
//  MusicCloud
//
//  Created by Quang Pham on 28/11/2020.
//

import UIKit

final class PlayerVC: UIViewController {

    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var miniPlayerView: MiniPlayerView!
    @IBOutlet private weak var btnClose: UIButton!
    @IBOutlet private weak var btnMore: UIButton!
    @IBOutlet private weak var viewBackground: UIImageView!
    @IBOutlet private weak var lblSong: MarqueeLabel!
    @IBOutlet private weak var lblArtist: MarqueeLabel!
    @IBOutlet weak var carouselCollectionView: ScalingCarouselCollectionView!
    
    private var tracks = [Track]()
    var onTappedClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        carouselCollectionView.register(UINib(nibName: PlayingTrackCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: PlayingTrackCell.identifier)
        viewBackground.addBlurEffect()
        lblSong.type = .leftRight
        lblSong.speed = .rate(40)
        lblSong.fadeLength = 5
        lblSong.animationDelay = 2
        lblArtist.type = .leftRight
        lblArtist.speed = .rate(40)
        lblArtist.animationDelay = 2
    }
    
    func updateModel(tracks: [Track], selectedIndex: Int) {
        self.tracks = tracks
        carouselCollectionView.reloadData()
        updateTrack(track: tracks[selectedIndex], index: selectedIndex)
        miniPlayerView.updateTrack(track: tracks[selectedIndex])
    }
    
    private func updateTrack(track: Track, index: Int) {
        lblSong.text = track.title
        lblArtist.text = track.user?.username
        carouselCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    @IBAction func btnMoreClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        onTappedClose?()
    }
}

extension PlayerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayingTrackCell.identifier, for: indexPath)
                as? PlayingTrackCell else { fatalError("Cannot create new cell") }
        
        DispatchQueue.main.async {
            cell.setupCell(track: self.tracks[indexPath.row])
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
}

extension PlayerVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
