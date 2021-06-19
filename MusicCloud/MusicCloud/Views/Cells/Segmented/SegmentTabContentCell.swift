//
//  SegmentTabContentCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 07/12/2020.
//

import UIKit

class TabDetailContentCollectionViewCell: UICollectionViewCell {
        
    private let layout: UICollectionViewFlowLayout = {
        var flayout = UICollectionViewFlowLayout()
        flayout.scrollDirection = .vertical
        flayout.minimumLineSpacing = 0
        flayout.minimumInteritemSpacing = 0
        return flayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(DemoCollectionViewCell.self, forCellWithReuseIdentifier: "DemoCollectionViewCell") 
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.setCollectionViewLayout(layout, animated: false)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(collectionView)
        collectionView.fillLayoutInView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabDetailContentCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemoCollectionViewCell", for: indexPath) as! DemoCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
