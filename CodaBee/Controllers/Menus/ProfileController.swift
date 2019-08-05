//
//  ProfileController.swift
//  CodaBee
//
//  Created by Bernard Masset on 30/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class ProfileController: MoveableController {
    
    @IBOutlet weak var profileView: CustomView!
    
    @IBOutlet weak var profileIV: RoundIV!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var validerButton: UIButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    var beeUser: BeeUser?
    var canAdd = false
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
        if let user = beeUser {
            profileIV.download(string: user.imageUrl)
            usernameTF.placeholder = user.username
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
/////////////
    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(validerButton, centerConstraint)
    }
    
    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, centerConstraint)
    }

////////////
    
    @IBAction func cameraAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func libraryAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func logAction(_ sender: Any) {
        // se connecter
        FirebaseHelper().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func valideAction(_ sender: Any) {
        view.endEditing(true)
        //dismiss(animated: true, completion: nil)
        if canAdd, usernameTF.text != nil {
            // Modifier notre utilisateur
            if let user = beeUser {
                FirebaseHelper().updateUser(user.id, dict: ["username" : self.usernameTF.text!])
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func usernameEnter(_ sender: UITextField) {
        FirebaseHelper().usernameExist(sender.text) { (bool, string) in
            DispatchQueue.main.async {
                self.errorLbl.text = string
                self.canAdd = bool
            }
        }
    }
    
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originale = info[.originalImage] as? UIImage {
            self.profileIV.image = originale
            // Formatter image
            if let data = originale.jpegData(compressionQuality: 0.2) {
                //FirebaseHelper().addProfilePicture(data)
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
