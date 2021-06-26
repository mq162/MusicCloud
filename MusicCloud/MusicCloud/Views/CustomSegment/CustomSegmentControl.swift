//
//  CustomSegmentControl.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/12/2020.
//

import UIKit

protocol SegmentedActivityDelegate: AnyObject {
    func scrollTo(index: Int)
}
    
class CustomSegmentedControl: UIView {
    
    var trackViewLeadingAnchor: NSLayoutConstraint?
    
    weak var delegate: SegmentedActivityDelegate?
    
    let tabArr = ["Tracks", "Playlists", "Likes"]
    
    private let seperatorView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 211/255, green: 208/255, blue: 208/255, alpha: 1)
        return v
    }()
    
    private let trackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 38/255, green: 155/255, blue: 255/255, alpha: 1)
        return v
    }()
        
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = true
        cv.register(SegmentedTabCell.self, forCellWithReuseIdentifier: "SegmentedTabCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(collectionView)
        addSubview(seperatorView)
        addSubview(trackView)
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        collectionView.fillLayoutInView(view: self)
        NSLayoutConstraint.activate([
            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.7),
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        trackViewLeadingAnchor = trackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        trackViewLeadingAnchor?.isActive = true
        trackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(tabArr.count)).isActive = true
        trackView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        trackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension CustomSegmentedControl: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentedTabCell", for: indexPath) as? SegmentedTabCell else { fatalError("Cannot create new cell")}
        cell.setTabText(text: tabArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedW = (collectionView.frame.width / CGFloat(tabArr.count))
        return CGSize(width:estimatedW, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.scrollTo(index: indexPath.row)
    }
}
