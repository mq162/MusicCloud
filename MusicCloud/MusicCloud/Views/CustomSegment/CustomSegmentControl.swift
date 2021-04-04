//
//  CustomSegmentControl.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/12/2020.
//

import UIKit

protocol SegmentedActivityDelegate: class {
    func scrollTo(index: Int)
}
    
class CustomSegmentedControl: UIView {
    
    var trackViewLeadingAnchor:NSLayoutConstraint?
    
    weak var delegate: SegmentedActivityDelegate?
    
    let tabArr = ["Tab 1", "Tab 2", "Tab 3", "Tab 4"]
    
    let seperatorView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 211/255, green: 208/255, blue: 208/255, alpha: 1)
        return v
    }()
    
    let trackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 38/255, green: 155/255, blue: 255/255, alpha: 1)
        return v
    }()
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = true
        cv.register(SegmentedTabCell.self, forCellWithReuseIdentifier: "SegmentedTabCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.setCollectionViewLayout(layout, animated: false)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(seperatorView)
        addSubview(trackView)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            
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
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        addSubview(collectionView)
        addSubview(seperatorView)
        addSubview(trackView)
        setUpConstraints()
    }
    
}

extension CustomSegmentedControl:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentedTabCell", for: indexPath) as! SegmentedTabCell
        cell.tabLabel.text = tabArr[indexPath.row]
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
