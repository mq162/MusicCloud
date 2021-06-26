//
//  PlayingTrackCell.swift
//  MusicCloud
//
//  Created by Quang Phạm on 26/06/2021.
//

import UIKit

final class PlayingTrackCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imgArtwork: UIImageView!
    
    static let identifier = String(describing: PlayingTrackCell.self)
    
    var scaleMinimum: CGFloat = 0.9
    
    /// Divisior used when calculating the scale value.
    /// Lower values cause a greater difference in scale between subsequent cells.
    var scaleDivisor: CGFloat = 10.0
    
    /// The minimum value to alpha to, should be set between 0 and 1
    var alphaMinimum: CGFloat = 0.85
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let carouselView = superview as? ScalingCarouselCollectionView else { return }
        
        scale(withCarouselInset: carouselView.inset)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.transform = CGAffineTransform.identity
        containerView.alpha = 1.0
    }
    
    func setupCell(track: Track) {
        imgArtwork.loadArtwork(path: track.artworkUrl)
    }

    func scale(withCarouselInset carouselInset: CGFloat) {
        
        // Ensure we have a superView, and mainView
        guard let superview = superview,
            let containerView = containerView else { return }
        
        // Get our absolute origin value and width/height based on the scroll direction
        var origin = superview.convert(frame, to: superview.superview).origin.x
        var contentWidthOrHeight = frame.size.width
        if let collectionView = superview as? ScalingCarouselCollectionView, collectionView.scrollDirection == .vertical {
            origin = superview.convert(frame, to: superview.superview).origin.y
            contentWidthOrHeight = frame.size.height
        }
        
        // Calculate our actual origin.x value using our inset
        let originActual = origin - carouselInset
        
        
        // Calculate our scale values
        let scaleCalculator = abs(contentWidthOrHeight - abs(originActual))
        let percentageScale = (scaleCalculator/contentWidthOrHeight)
        
        let scaleValue = scaleMinimum
            + (percentageScale/scaleDivisor)
        
        let alphaValue = alphaMinimum
            + (percentageScale/scaleDivisor)
        
        let affineIdentity = CGAffineTransform.identity
        
        // Scale our mainView and set it's alpha value
        containerView.transform = affineIdentity.scaledBy(x: scaleValue, y: scaleValue)
        containerView.alpha = alphaValue
    }
    
}
