//
//  BaseLargeTitleNavBarVC.swift
//  MusicCloud
//
//  Created by Quang Phạm on 22/06/2021.
//

import UIKit

class BaseLargeTitleNavBarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeTitleNavBar()
    }
    
    private func setupLargeTitleNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: UIFont(name: "CircularStd-Book", size: 18) ??
                                                   UIFont.systemFont(ofSize: 18)]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                     NSAttributedString.Key.font: UIFont(name: "CircularStd-Bold", size: 26) ??
                                                        UIFont.systemFont(ofSize: 26)]
        navBarAppearance.backgroundColor = UIColor(named: "bg_navbar")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
