//
//  ForumController.swift
//  CodaBee
//
//  Created by Bernard Masset on 21/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class ForumController: UIViewController, SideMenuItemContent {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forum"

    }
    

    @IBAction func addQuestion(_ sender: Any) {
    }
    
    @IBAction func showMenu(_ sender: Any) {
        showSideMenu()
    }
}
