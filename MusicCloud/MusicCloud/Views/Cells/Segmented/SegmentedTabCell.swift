//
//  SegmentedTabCell.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/12/2020.
//

import UIKit

final class SegmentedTabCell: UICollectionViewCell {
        
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
    
    private let tabLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        return l
    }()
    
    func setTabText(text: String) {
        print(text)
        tabLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabLabel)
        tabLabel.centerInView(parent: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
