//
//  LoadingImageView.swift
//  CodaBee
//
//  Created by Bernard Masset on 25/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView {

    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        image = UIImage(named: "darkBee")
        contentMode = .scaleAspectFit
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (t) in
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        })
    }
    
    func stop() {
        timer.invalidate()
    }
    
}
