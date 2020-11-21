//
//  Utils.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import NVActivityIndicatorView
import UIKit

class Utils {

    static func showLoadingIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .lineScalePulseOut, color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
    }

    static func hideLoadIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
