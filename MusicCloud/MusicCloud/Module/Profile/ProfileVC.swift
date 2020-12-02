//
//  ProfileVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 18/11/2020.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet private weak var headerBackView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var headerUsernameLabel: UILabel!
    @IBOutlet private weak var headerBlurView: UIVisualEffectView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var profileImageContainerView: UIView!
    @IBOutlet private weak var profileImageContainerViewWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.makeTransparent()
        usernameLabel.text = "Quang Pham"
        headerUsernameLabel.text = "Quang Pham"
        descriptionLabel.text = "im aidan. music is my life. listen and take a trip inside my head"
        profileImageView.image = #imageLiteral(resourceName: "background-image")
        headerImageView.image = #imageLiteral(resourceName: "background-image")
        headerBlurView.alpha = 0.0
        scrollView.delegate = self
    }
}

extension ProfileVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let profileContainerWidth: CGFloat = {
            let min = type(of: self).Metrics.ProfileIconWidth.min
            let max = type(of: self).Metrics.ProfileIconWidth.max
            let width = type(of: self).Metrics.ProfileIconWidth.max - scrollView.contentOffset.y
            return width.clamp(to: min...max)
        }()
        
        profileImageContainerViewWidth.constant = profileContainerWidth
        profileImageContainerView.circularize()
        profileImageView.circularize()
        
        if profileContainerWidth > type(of: self).Metrics.ProfileIconWidth.min {
            scrollView.bringSubviewToFront(profileImageContainerView)
        } else {
            scrollView.bringSubviewToFront(headerView)
        }
        
        headerBlurView.alpha = ((scrollView.contentOffset.y - 40) / headerBackView.frame.height)
            .clamp(to: (0.0...1.0))
    }
}

extension ProfileVC {
    enum Metrics {
        enum ProfileIconWidth {
            static let min: CGFloat = 60.0
            static let max: CGFloat = 100.0
        }
    }
}
