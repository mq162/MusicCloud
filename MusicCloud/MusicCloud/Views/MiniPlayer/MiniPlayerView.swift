//
//  MiniPlayerView.swift
//  MusicCloud
//
//  Created by Quang Pham on 28/11/2020.
//

import UIKit

@IBDesignable class MiniPlayerView: BaseView {

    @IBOutlet private weak var imgArtwork: UIImageView!
    @IBOutlet private weak var lblTitle: MarqueeLabel!
    @IBOutlet private weak var lblArtist: MarqueeLabel!
    @IBOutlet private weak var btnPlay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.type = .leftRight
        lblTitle.speed = .rate(40)
        lblTitle.fadeLength = 5
        lblTitle.animationDelay = 2
        lblTitle.text = "Versace On The Floors Baby"
        lblArtist.type = .leftRight
        lblArtist.speed = .rate(40)
        lblArtist.animationDelay = 2
    }
    
    @IBAction func btnPlayClicked(_ sender: UIButton) {
        
    }
    
}
