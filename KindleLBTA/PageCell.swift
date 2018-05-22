//
//  PageCell.swift
//  KindleLBTA
//
//  Created by Ruslan Suvorov on 5/21/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            textLabel.text = page?.text
        }
    }
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
