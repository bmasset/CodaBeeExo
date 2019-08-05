//
//  RoundIV.swift
//  CodaBee
//
//  Created by Bernard Masset on 23/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class RoundIV: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = frame.height / 2
        layer.borderColor = HONEY_COLOR.cgColor
        layer.borderWidth = 2
    }
    
}
