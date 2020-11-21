//
//  TrackGridCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import UIKit

class TrackGridCell: UICollectionViewCell {

    @IBOutlet private weak var imgArtwork: UIImageView!
    
    static let identifier = String(describing: TrackGridCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(track: Track) {
        imgArtwork.loadArtwork(path: track.artwork_url)
    }
}
