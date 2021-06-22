//
//  LoadingFooterCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import UIKit
import NVActivityIndicatorView

class LoadingFooterCell: UICollectionReusableView {
    
    static let reuseIdentifier = "loading-cell"
    private var activityIndicator: NVActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showLoadingIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension LoadingFooterCell {
    
    func showLoadingIndicator() {
        if activityIndicator == nil {
            activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 20.0), type: NVActivityIndicatorType.lineScalePulseOut, color: #colorLiteral(red: 0.0862745098, green: 0.6549019608, blue: 1, alpha: 1))
            
            self.addSubview(activityIndicator)
            activityIndicator.centerInView(parent: self)
        }
        activityIndicator.startAnimating()
    }

    func stopLoadingIndicator(){
        activityIndicator.stopAnimating()
    }
}
