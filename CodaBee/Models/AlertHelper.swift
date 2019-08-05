//
//  AlertHelper.swift
//  CodaBee
//
//  Created by Bernard Masset on 31/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class AlertHelper {
    
    func erreurSimple(_ controller:UIViewController, message: String) {
        let alerte = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerte.addAction(ok)
        controller.present(alerte, animated: true, completion: nil)
    }
}
