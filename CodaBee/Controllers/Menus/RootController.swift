//
//  RootController.swift
//  CodaBee
//
//  Created by Bernard Masset on 21/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class RootController: MenuContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Transition
        transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: 50)
        
        // MenuController
        if let menu = getInitial(string: "Menu") as? MenuViewController {
            menuViewController = menu
        }
        
        // Contenu
        contentViewControllers = [
            getInitial(string: "Actus"),
            getInitial(string: "Video"),
            getInitial(string: "Forum")
        ]
        
        // Sélectionner le premier du contrnu comme visible au départ
        if contentViewControllers.count > 0 {
            selectContentViewController(contentViewControllers.first!)
        }
    }
    
    func getInitial(string: String) -> UIViewController {
        let storyboard = UIStoryboard(name: string, bundle: nil)
        return storyboard.instantiateInitialViewController() ?? UIViewController()
    }
}
