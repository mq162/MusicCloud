//
//  ProfileVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 18/11/2020.
//

import UIKit
import Alamofire

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
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var customSegmented: CustomSegmentedControl!
    @IBOutlet private weak var tracksView: UserStatView!
    @IBOutlet private weak var followersView: UserStatView!
    @IBOutlet private weak var followingsView: UserStatView!
    
    private let layout: UICollectionViewFlowLayout = {
        let v = UICollectionViewFlowLayout()
        v.scrollDirection = .horizontal
        v.minimumInteritemSpacing = 0
        v.minimumLineSpacing = 0
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(TabDetailContentCollectionViewCell.self, forCellWithReuseIdentifier: "TabDetailContentCollectionViewCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.setCollectionViewLayout(layout, animated: false)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegmented.delegate = self
        navigationController?.makeTransparent()
        headerBlurView.alpha = 0.0
        scrollView.delegate = self
        setupTab()
        fetchUserData()
    }
    
    private func setupTab() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: customSegmented.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension ProfileVC {
    private func fetchUserData() {
        HttpRequests.request(request: MeProfileAPI()) { [weak self] (result, response) in
            if (result) {
                self?.updateView(model: response.profile)
            } else {
                print(response.getErrorMessage())
            }
        }
    }
    
    private func updateView(model: User) {
        descriptionLabel.text = model.description ?? ""
        usernameLabel.text = model.username ?? ""
        headerUsernameLabel.text = model.username ?? ""
        tracksView.setStat(text: String(model.trackCount ?? 0))
        followersView.setStat(text: String(model.followersCount ?? 0))
        followingsView.setStat(text: String(model.followingsCount ?? 0))
        profileImageView.loadArtwork(path: model.avatarUrl)
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
        
        
        if scrollView.contentOffset.y > 250 {
                scrollView.contentOffset.y = 250
             }
        
        let x = scrollView.contentOffset.x / CGFloat(customSegmented.tabArr.count)
        customSegmented.trackViewLeadingAnchor?.constant = x
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(velocity)
        let i = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        let indexPath = IndexPath(item: i, section: 0)
        customSegmented.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customSegmented.tabArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabDetailContentCollectionViewCell", for: indexPath) as! TabDetailContentCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ProfileVC: SegmentedActivityDelegate {
    func scrollTo(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
