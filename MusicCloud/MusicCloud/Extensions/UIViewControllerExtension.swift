//
//  UIViewControllerExtension.swift
//  MusicCloud
//
//  Created by Quang Pham on 28/11/2020.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, insets: UIEdgeInsets = .zero) {
        addChild(child)
        view.addSubview(child.view)
        child.view.fillLayoutInView(view: view)
        child.didMove(toParent: self)
    }
    
    func remove(_ child: UIViewController) {
        guard child.parent != nil else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func addToNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
