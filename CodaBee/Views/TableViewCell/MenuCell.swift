//
//  MenuCell.swift
//  CodaBee
//
//  Created by Bernard Masset on 23/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    func setup(_ string: String) {
        self.setup()
        nameLbl.text = string
    }
}
