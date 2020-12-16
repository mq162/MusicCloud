//
//  UserStatView.swift
//  MusicCloud
//
//  Created by Quang Pham on 02/12/2020.
//

import UIKit

@IBDesignable class UserStatView: UIView {
    
    @IBInspectable var title: String = ""
    
    private lazy var statLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        self.borderWidth = 1.0
        self.borderColors = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        //Stack View
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(statLabel)
        stackView.frame = self.bounds
        self.addSubview(stackView)
    }
    
    func setStat(text: String) {
        self.statLabel.text = text
    }
}
