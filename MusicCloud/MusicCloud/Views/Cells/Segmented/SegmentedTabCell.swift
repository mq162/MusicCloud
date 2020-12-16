//
//  SegmentedTabCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/12/2020.
//

import UIKit

class SegmentedTabCell: UICollectionViewCell {
    
    override var isHighlighted: Bool{
        didSet{
            tabLabel.textColor = isHighlighted ? UIColor(red: 38/255, green: 155/255, blue: 255/255, alpha: 1) : UIColor(red: 211/255, green: 208/255, blue: 208/255, alpha: 1)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            tabLabel.textColor = isSelected ? UIColor(red: 38/255, green: 155/255, blue: 255/255, alpha: 1) : UIColor(red: 211/255, green: 208/255, blue: 208/255, alpha: 1)
        }
    }
    
    let tabLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Tab 1"
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabLabel)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            tabLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tabLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
