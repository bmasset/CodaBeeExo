//
//  ExtensionUI.swift
//  CodaBee
//
//  Created by Bernard Masset on 23/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import SDWebImage

extension UITableView {
    
    func setup(color: UIColor) {
        backgroundColor = color
        separatorStyle = .none
        tableFooterView = UIView()
    
    }
}

extension UITableViewCell {
    
    func setup() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
}

extension UIImageView {
    
    func download(string:String) {
        sd_setImage(with: URL(string: string), placeholderImage: BUMBLE_IMAGE, options: SDWebImageOptions.highPriority, completed: nil)
    }
}
