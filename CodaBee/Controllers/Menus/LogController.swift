//
//  LogController.swift
//  CodaBee
//
//  Created by Bernard Masset on 29/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class LogController: MoveableController {

    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameErrorLbl: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    
    @IBOutlet weak var logView: CustomView!
    
    @IBOutlet weak var centerViewConstraint: NSLayoutConstraint!
    
    var canAdd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addTap()
        
    }
    
    @IBAction func usernameChanged(_ sender: UITextField) {
        // Vérifier dans la base de données si Username existe
        FirebaseHelper().usernameExist(sender.text) { (bool, string) in
            DispatchQueue.main.async {
                self.canAdd = bool
                self.usernameErrorLbl.text = string
            }
        }
    }
    
    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(logView, centerViewConstraint)
    }
    
    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, centerViewConstraint)
    }

    func setup() {
        switch segmented.selectedSegmentIndex {
        case 0:
            // Pb avec le champ usernameTF
            // normalement on devrait avoir true
            // mais tout disparaît si true
            // cause ??
            usernameTF.isHidden = false
            connectButton.setTitle("Se connecter", for: .normal)
        default:
            usernameTF.isHidden = false
            connectButton.setTitle("Créer un compte", for: .normal)
        }
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        setup()
        
    }

    @IBAction func connectPressed(_ sender: Any) {
        // Vérifier mail et mdp
        if let mail = emailTF.text, mail != "" {
            if let mdp = passwordTF.text, mdp != "" {
                if segmented.selectedSegmentIndex == 0 {
                    FirebaseHelper().signIn(mail, mdp, result: logCompletion)
                } else {
                    // Vérifier si username existe
                    if canAdd, let username = usernameTF.text {
                        FirebaseHelper().create(mail, mdp, username: username, result:logCompletion)
                    }
                }
            } else {
                // Alerter
                AlertHelper().erreurSimple(self, message: "mot de passe vide")

            }
        } else {
            // Alerter
            AlertHelper().erreurSimple(self, message: "adresse mail vide")

        }
        // Créer

    }
    
    func logCompletion(_ bool:Bool?, _ error: Error?) {
        if error != nil {
            // Alerter
            AlertHelper().erreurSimple(self, message: error!.localizedDescription)
        }
        if bool != nil, bool == true {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func retourButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
    }

}
