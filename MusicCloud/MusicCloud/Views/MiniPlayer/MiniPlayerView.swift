//
//  MiniPlayerView.swift
//  MusicCloud
//
//  Created by Quang Pham on 28/11/2020.
//

import UIKit

class MiniPlayerView: BaseView {

    @IBOutlet private weak var imgArtwork: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblArtist: UILabel!
    @IBOutlet private weak var btnPlay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnPlayClicked(_ sender: UIButton) {
        
    }
    
}
