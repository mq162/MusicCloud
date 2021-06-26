//
//  ScalingCarouselLayout.swift
//  MusicCloud
//
//  Created by Quang Phạm on 26/06/2021.
//

import UIKit

/*
 ScalingCarouselLayout is used together with SPBCarouselView to
 provide a carousel-style collection view.
*/
open class ScalingCarouselLayout: UICollectionViewFlowLayout {

    open var inset: CGFloat = 0.0
    
    
    /// Initialize a new carousel-style layout
    ///
    /// - parameter inset: The carousel inset
    ///
    /// - returns: A new carousel layout instance
    convenience init(withCarouselInset inset: CGFloat = 0.0) {
        self.init()
        self.inset = inset
    }
    
    override open func prepare() {
        
        guard let collectionViewSize = collectionView?.frame.size else { return }
        
        // Set itemSize based on total width and inset
        itemSize = collectionViewSize
        
        // Set scrollDirection and paging
        var direction: UICollectionView.ScrollDirection = .horizontal
        if let collectionView = collectionView as? ScalingCarouselCollectionView {
            direction = collectionView.scrollDirection
        }
        scrollDirection = direction
        
        // set item height/width and sectionInset based on scroll direction
        if scrollDirection == .vertical {
            itemSize.height = itemSize.height - (inset * 2)
            sectionInset = UIEdgeInsets(top: inset, left: 0.0, bottom: inset, right: 0.0)

        } else {
            itemSize.width = itemSize.width - (inset * 2)
            sectionInset = UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
        }
        collectionView?.isPagingEnabled = true
        
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        
        footerReferenceSize = CGSize.zero
        headerReferenceSize = CGSize.zero
    }
}

