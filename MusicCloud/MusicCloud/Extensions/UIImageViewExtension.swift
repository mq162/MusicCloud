//
//  UIImageViewExtension.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import UIKit
import Nuke

extension UIImageView {
    
    func loadArtwork(path: String?) {
        if let pathNotNil = path,
            let imageUrl = URL(string: pathNotNil) {
            Nuke.loadImage(with: imageUrl, into: self)
        }
    }
    
    func loadBackdrop(path: String?) {
        if let pathNotNil = path,
            let imageUrl = URL(string: pathNotNil) {
            Nuke.loadImage(with: imageUrl, into: self)
        }
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

