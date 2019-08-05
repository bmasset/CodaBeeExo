//
//  Nav.swift
//  CodaBee
//
//  Created by Bernard Masset on 23/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class Nav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .darkGray
        navigationBar.tintColor = HONEY_COLOR
        navigationBar.titleTextAttributes = [
            .foregroundColor: HONEY_COLOR,
            .font: UIFont.italicSystemFont(ofSize: 20)
        ]
    }
}
