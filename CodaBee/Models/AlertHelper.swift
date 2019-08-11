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
    
    func askQuestion(_ controller:UIViewController) {
        let alerte = UIAlertController(title: "Posez votre question", message: nil, preferredStyle: .alert)
        alerte.addTextField { (tf) in
            tf.placeholder = "Posez votre question"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            if let textFields = alerte.textFields {
                if textFields.count > 0 {
                    let textfield = textFields[0]
                    if let texte = textfield.text , texte != "" {
                        // Envoyer sur Firebase
                        print(texte)
                        FirebaseHelper().saveQuestion(texte)
                    }
                }
            }
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alerte.addAction(ok)
        alerte.addAction(cancel)
        controller.present(alerte, animated: true, completion: nil)
    }
    
}
