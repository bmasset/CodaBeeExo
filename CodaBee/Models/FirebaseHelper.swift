//
//  FirebaseHelper.swift
//  CodaBee
//
//  Created by Bernard Masset on 29/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class FirebaseHelper {
    
    var result: ((_ bool:Bool?,_ erreur:Error?) -> Void)?
    var userValues: [String: String] = [:]
    
    // Vérifier si utilisateur est connecté
    
    func connecte() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    // Authentification
    
    func signIn(_ mail: String,_ password: String, result: ((_ bool:Bool?,_ erreur:Error?) -> Void)?) {
        self.result = result
        Auth.auth().signIn(withEmail: mail, password: password, completion: completion)
    }
    
    func create(_ mail: String,_ password: String, username: String, result: ((_ bool:Bool?,_ erreur:Error?) -> Void)?) {
        self.result = result
        self.userValues = ["username": username]
        
        Auth.auth().createUser(withEmail: mail, password: password, completion: completion)
    }
    
    func completion(_ result: AuthDataResult?, error: Error?) {
        if let erreur = error {
            print(erreur.localizedDescription)
            // notifier l'erreur à l'utilisateur
            self.result?(false, erreur)
        }
        if let id = result?.user.uid {
            // mettre à jour la base de données
            updateUser(id, dict: self.userValues)
            // notifier Ok
            self.result?(true, nil)
            
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error.localizedDescription)
        }
        
    }

    // Accès à la base de données.

    private var _database = Database.database().reference()

    private var _databaseUsers: DatabaseReference {
        return _database.child("users")
    }

    private var _databaseQuestion: DatabaseReference {
        return _database.child("questions")
    }

    func updateUser(_ id: String, dict: [String:String]) {
        _databaseUsers.child(id).updateChildValues(dict)
        userValues = [:]
    }


    func getUser(_ id: String, completion: ((BeeUser) -> Void )?) {
        _databaseUsers.child(id).observe(.value) { (data) in
            //print(data)
            completion?(BeeUser(data: data))
        }
    }
    
    func usernameExist(_ username: String?, completion: ((Bool, String?) -> Void)?) {
        if let string = username {
            if string.count > 2 {
                _databaseUsers.queryOrdered(byChild: "username").queryEqual(toValue: string).observeSingleEvent(of: .value) { (data) in
                    if data.exists() {
                        completion?(false, "username déjà pris")
                    } else {
                        completion?(true, "")
                    }
                }
                
            } else {
                completion?(false,"Username trop court")
            }
        } else {
            completion?(false,"Username vide")
        }
    }
    
    // Storage
    
    private let _storage = Storage.storage().reference()
    private var _storageUser: StorageReference {
        return _storage.child("users")
    }
    
    func addProfilePicture(_ data: Data) {
        guard let id = connecte() else { return }
        let reference = _storageUser.child(id)
        reference.putData(data, metadata: nil) { (meta, error) in
            if error == nil {
                reference.downloadURL(completion: { (url, error) in
                    if let urlString = url?.absoluteString {
                        self.updateUser(id, dict: ["imageUrl" : urlString])
                    }
                })
            }
        }
    }
    
    
    

}
