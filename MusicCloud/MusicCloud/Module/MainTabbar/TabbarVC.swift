//
//  TabbarVC.swift
//  MusicCloud
//
//  Created by Quang Pham on 28/11/2020.
//

import UIKit

final class TabbarVC: UIViewController {

    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet weak var tabBarContainer: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    
    private var additionalBottomInset: CGFloat {
        get {
            return tabBar.bounds.height
        }
    }
    
    private lazy var playerViewController: PlayerVC = {
        let vc = PlayerVC()
        vc.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: additionalBottomInset, right: 0)
        vc.view.isHidden = true
        return vc
    }()
    
    private var coordinator: TransitionCoordinator!
    
    private var viewControllers = [UIViewController]()
    
    var shouldHideStatusBar: Bool = false
    private var previousIndex = 0
    private var activeIndex = 0
    private var isMiniPlayerShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabItems()
        self.tabBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        add(playerViewController)
        coordinator = TransitionCoordinator(tabBarViewController: self, playerViewController: playerViewController)
        view.bringSubviewToFront(tabBarContainer)
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    private func setupTabItems() {
        let streamVC = StreamVC()
        streamVC.onClickTrack = { [weak self] (tracks, index) in
            guard let weakSelf = self else { return }
            if !weakSelf.isMiniPlayerShowing {
                weakSelf.playerViewController.view.isHidden = false
            }
            weakSelf.playerViewController.updateModel(tracks: tracks, selectedIndex: index)
        }
        let streamNavi = UINavigationController(rootViewController: streamVC)
        
        let searchVC = SearchVC().addToNavigationController()
        let historyVC = HistoryVC().addToNavigationController()
        let profileVC = ProfileVC().addToNavigationController()

        viewControllers = [streamNavi, searchVC, historyVC, profileVC]
        didSelectTab()
    }
    
    private func didSelectTab() {
        let previousVC = viewControllers[previousIndex]
        remove(previousVC)
        
        let activeVC = viewControllers[activeIndex]
        addChild(activeVC)
        guard let activeView = activeVC.view else { return }
        activeView.frame = view.frame
        viewContainer.addSubview(activeView)
        activeVC.didMove(toParent: self)
        activeVC.view.fillLayoutInView(view: viewContainer)
    }
    
    private func setupUI() {
        let appearance = tabBar.standardAppearance
        appearance.configureWithTransparentBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
        tabBar.selectedItem = tabBar.items?.first
    }
}

extension TabbarVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.previousIndex = activeIndex
        self.activeIndex = item.tag
        if activeIndex != previousIndex {
            self.didSelectTab()
        }
    }
}
