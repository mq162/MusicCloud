//
//  TrackCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    static let identifier = String(describing: TrackCell.self)
    
    @IBOutlet private weak var lblTrackname: UILabel!
    @IBOutlet private weak var imgArtwork: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(track: Track) {
        imgArtwork.loadArtwork(path: track.artworkUrl)
        lblTrackname.text = track.title
        lblUsername.text = track.user?.username
    }
    
    @IBAction func btnLikeClicked(_ sender: UIButton) {
    }
    
    @IBAction func btnMoreClicked(_ sender: UIButton) {
    }
}
