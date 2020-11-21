//
//  UIViewExtension.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColors: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        var position = layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        layer.position = position
        layer.anchorPoint = point
    }

    func dropShadow(shadowRadius : Double,offsetWidth: Double,offsetHight : Double) {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(named: "shadowColor")?.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHight)
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func circleShadow(shadowRadius : Double,offsetWidth: Double,offsetHight : Double) {
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8, green: 0.8156862745, blue: 0.8352941176, alpha: 1)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHight)
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func fillLayoutInView(view: UIView, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        ])
    }
}
