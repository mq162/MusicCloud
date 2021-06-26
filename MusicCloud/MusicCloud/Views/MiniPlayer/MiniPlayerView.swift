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
    @IBOutlet private weak var btnPlay: UIButton!
    
    var isPlaying = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.type = .leftRight
        lblTitle.speed = .rate(40)
        lblTitle.fadeLength = 5
        lblTitle.animationDelay = 2
    }
    
    @IBAction func btnPlayClicked(_ sender: UIButton) {
        isPlaying = !isPlaying
        updateButtonState()
    }
    
    func updateTrack(track: Track) {
        lblTitle.text = track.title
        imgArtwork.loadArtwork(path: track.artworkUrl)
    }
    
    private func updateButtonState() {
        let image = isPlaying ? UIImage(systemName: "pause.fill") : UIImage(systemName: "play.fill")
        btnPlay.setImage(image, for: .normal)
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.btnPlay.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.btnPlay.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
    }
    
}
