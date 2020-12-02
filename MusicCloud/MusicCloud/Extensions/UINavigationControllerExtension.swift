//
//  UINavigationControllerExtension.swift
//  MusicCloud
//
//  Created by Quang Pham on 02/12/2020.
//

import UIKit

extension UINavigationController {
    func makeTransparent() {
        isNavigationBarHidden = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
}
