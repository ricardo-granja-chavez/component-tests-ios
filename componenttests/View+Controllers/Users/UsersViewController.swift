//
//  UsersViewController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var usersTableView: UsersTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.getUsers()
    }
 
    private func setupTableView() {
        usersTableView.delegate = usersTableView
        usersTableView.dataSource = usersTableView
        usersTableView.onPress = { (user) in
            let vc = UserDetailsViewController(user: user)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getUsers() {
        UserServices.shared.getUsers { (result) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.usersTableView.collection = UserListViewModel(users: users)
                    self.usersTableView.reloadData()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
