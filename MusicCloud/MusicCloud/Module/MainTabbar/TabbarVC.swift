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
        vc.view.isHidden = true
        vc.additionalSafeAreaInsets.bottom = additionalBottomInset
        view.insertSubview(vc.view, belowSubview: self.tabBarContainer)
        vc.view.fillLayoutInView(view: view)
        return vc
    }()
    
    private var coordinator: TransitionCoordinator!
    
    private var viewControllers = [UIViewController]()
    
    var shouldHideStatusBar: Bool = false
    private var previousIndex = 0
    private var activeIndex = 0
    private var isMiniPlayerShowing = false
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        setupUI()
        setupTabItems()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPlayer()
        coordinator = TransitionCoordinator(tabBarViewController: self, playerViewController: playerViewController)
        view.bringSubviewToFront(tabBarContainer)
    }
    
    private func setupPlayer() {
        addChild(playerViewController)
        playerViewController.didMove(toParent: self)
    }
    
    private func displayMiniPlayer(tracks: [Track], index: Int) {
        playerViewController.updateModel(tracks: tracks, selectedIndex: index)
        if isMiniPlayerShowing { return }
        isMiniPlayerShowing = true
        playerViewController.view.isHidden = false
        playerViewController.view.frame = tabBarContainer.frame
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.playerViewController.view.frame = self.view.frame
                self.view.layoutIfNeeded()
            })
    }
    
    private func setupTabItems() {
        let streamVC = StreamVC()
        streamVC.onClickTrack = { [weak self] (tracks, index) in
            guard let weakSelf = self else { return }
            weakSelf.displayMiniPlayer(tracks: tracks, index: index)
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
