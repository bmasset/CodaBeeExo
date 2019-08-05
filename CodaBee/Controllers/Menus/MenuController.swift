//
//  MenuController.swift
//  CodaBee
//
//  Created by Bernard Masset on 21/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class MenuController: MenuViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileIV: RoundIV!
    
    var items = ["Fil d'actualité", "Vidéos", "Forum"]
    var beeUser: BeeUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setup(color: .clear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id = FirebaseHelper().connecte() {
            // L'utilisateur est connecté, récupérer beeUser
            FirebaseHelper().getUser(id) { (bee) in
                DispatchQueue.main.async {
                    self.beeUser = bee
                    if self.beeUser != nil {
                        self.profileIV.download(string: self.beeUser!.imageUrl)
                        self.usernameLbl.text = self.beeUser?.username
                        self.logButton.setTitle("Profile", for: .normal)
                    }
                }
            }
            
            logButton.setTitle("Profil", for: .normal)
            usernameLbl.text = "Ok"
            print("Utilisateur connecté")
        } else {
            // Pas d'utilisateur
            self.beeUser = nil
            logButton.setTitle("Se connecter", for: .normal)
            usernameLbl.text = ""
            print("Pas d'utilisateur")
        }
    }
    
    @IBAction func logButtonPressed(_ sender: Any) {
        if beeUser != nil {
            // vers profil
            print("Utilisateur Ok")
            performSegue(withIdentifier: "Profile", sender: beeUser!)
        } else {
            // aller vers connection
            print("Aller vers Connection")
            performSegue(withIdentifier: "Log", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profile" {
            if let nav = segue.destination as? Nav {
                if let first = nav.topViewController as? ProfileController {
                    first.beeUser = sender as? BeeUser
                }
            }
        }
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuContainerViewController?.contentViewControllers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell {
            cell.setup(items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row] == "Forum", FirebaseHelper().connecte() == nil {
            AlertHelper().erreurSimple(self , message: "Vous devez être connecté pour accéder au Forum."  )
        } else {
            
            if let main = menuContainerViewController {
                main.selectContentViewController(main.contentViewControllers[indexPath.row])
                main.hideSideMenu()
            }
        }
    }
}
