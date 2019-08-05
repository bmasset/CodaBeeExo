//
//  MoveableController.swift
//  CodaBee
//
//  Created by Bernard Masset on 30/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

// Déplacer vue et observer le clavier et ajouter tapGesture

class MoveableController: UIViewController {

    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showKey), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKey), name: UIWindow.keyboardDidHideNotification, object: nil)

    }
    
    @objc func showKey(notification: Notification) {
        if let keyHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            height = keyHeight
        }
    }

    @objc func hideKey(notification: Notification) {
        // Rien pour le moment
    }

    func addTap() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }

    @objc func tap() {
        view.endEditing(true)
    }
    
    func animation(_ constante: CGFloat, _ constraint: NSLayoutConstraint) {
        UIView.animate(withDuration: 0.5) {
            // vérifier
            constraint.constant = constante
        }
    }

    func checkHeight(_ view: UIView, _ constraint: NSLayoutConstraint) {
            let bottom = view.frame.maxY
            let screenHeight = UIScreen.main.bounds.height
            let remain = screenHeight - bottom - 20
            if height > remain {
                let constant = remain - height
                animation(constant, constraint)
            }
        }
}

