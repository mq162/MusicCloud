//
//  TrackCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    static let identifier = String(describing: TrackCell.self)
    
    @IBOutlet private weak var lblUserName: UIButton!
    @IBOutlet private weak var lblTrackname: UILabel!
    @IBOutlet private weak var imgArtwork: UIImageView!
    @IBOutlet private weak var lblPlaybackCount: UILabel!
    @IBOutlet private weak var lblRepostCount: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(track: Track) {
        imgArtwork.loadArtwork(path: track.artworkUrl)
        lblTrackname.text = track.title
        lblUserName.setTitle(track.user?.username, for: .normal)
        lblPlaybackCount.text = String(track.playbackCount ?? 0)
        lblRepostCount.text = String(track.repostsCount ?? 0)
    }
}
