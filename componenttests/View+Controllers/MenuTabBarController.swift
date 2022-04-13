//
//  MenuTabBarController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit

class MenuTabBarController: UITabBarController {
    
    private var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usersVC = UsersViewController()
        usersVC.tabBarItem = UITabBarItem(title: "Usuarios", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        self.controllers.append(usersVC)
        
        self.viewControllers = self.controllers
    }
    
}
