//
//  BookCell.swift
//  KindleLBTA
//
//  Created by Ruslan Suvorov on 5/21/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("cell is being initialized")
        backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
