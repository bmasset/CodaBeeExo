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

    var questions: [Question] = []
    var questionsTriees: [Question] = []
    var tri = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forum"
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate  = self
        tableView.setup(color: HONEY_COLOR)
    }
    

    @IBAction func addQuestion(_ sender: Any) {
    }
    
    @IBAction func showMenu(_ sender: Any) {
        showSideMenu()
    }
}

extension ForumController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tri ? questionsTriees.count : questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionCell {
            cell.setup(getQuestion(indexPath))
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func getQuestion(_ indexPath: IndexPath) -> Question {
        if tri {
            return questionsTriees[indexPath.row]
        } else {
            return questions[indexPath.row]
        }
    }
}

extension ForumController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text != "" {
            tri = true
            questionsTriees = questions.filter {
                $0.questionString.lowercased().contains(text.lowercased())
            }
        } else {
            tri = false
        }
    }
}
