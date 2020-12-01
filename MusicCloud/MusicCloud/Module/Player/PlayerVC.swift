//
//  PlayerVC.swift
//  MusicCloud
//
//  Created by Quang Pham on 28/11/2020.
//

import UIKit

class PlayerVC: UIViewController {

    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var miniPlayerView: MiniPlayerView!
    @IBOutlet private weak var btnClose: UIButton!
    @IBOutlet private weak var btnMore: UIButton!
    @IBOutlet private weak var viewBackground: UIImageView!
    @IBOutlet private weak var lblSong: MarqueeLabel!
    @IBOutlet private weak var lblArtist: MarqueeLabel!
    
    var onTappedClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        viewBackground.addBlurEffect()
        lblSong.type = .leftRight
        lblSong.speed = .rate(40)
        lblSong.fadeLength = 5
        lblSong.animationDelay = 2
        lblSong.text = "Versace On The Floors Baby"
        lblArtist.type = .leftRight
        lblArtist.speed = .rate(40)
        lblArtist.animationDelay = 2
    }
    
    @IBAction func btnMoreClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        onTappedClose?()
    }
}
