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
            activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 20.0), type: NVActivityIndicatorType.lineScalePulseOut, color: #colorLiteral(red: 0.2588235294, green: 0.7568627451, blue: 0.968627451, alpha: 1))
            
            // add subview
            self.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            // constraints
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        activityIndicator.startAnimating()
    }

    func stopLoadingIndicator(){
        activityIndicator.stopAnimating()
    }
}
