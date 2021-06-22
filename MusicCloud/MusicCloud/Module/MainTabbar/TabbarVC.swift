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
    
    private var viewControllers = [UIViewController]()
    private lazy var playerViewController = PlayerVC()
    private var coordinator: TransitionCoordinator!
    
    var shouldHideStatusBar: Bool = false
    private var previousIndex = 0
    private var activeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabItems()
        add(playerViewController)
        view.bringSubviewToFront(tabBarContainer)
        self.tabBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let additionalBottomInset = tabBar.bounds.height
        playerViewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: additionalBottomInset, right: 0)
        coordinator = TransitionCoordinator(tabBarViewController: self, playerViewController: playerViewController)
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    private func setupTabItems() {
        let streamVC = StreamVC().addToNavigationController()
        let searchVC = SearchVC().addToNavigationController()
        let historyVC = HistoryVC().addToNavigationController()
        let profileVC = ProfileVC().addToNavigationController()

        viewControllers = [streamVC, searchVC, historyVC, profileVC]
        didSelectTab()
    }
    
    private func didSelectTab() {
        let previosVC = viewControllers[previousIndex]
        remove(previosVC)
        
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
