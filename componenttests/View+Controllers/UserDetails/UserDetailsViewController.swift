//
//  UserDetailsViewController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var userDetailsTableView: UserDetailsTableView!
    private var user: UserViewModel!
    
    convenience init(user: UserViewModel) {
        self.init()
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "User Details"
        self.setupTableView()
    }
 
    private func setupTableView() {
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.id.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.name.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.username.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.email.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.phone.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.website.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.address.rawValue)
        userDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UserDetailsTableView.ReuseIdentifiers.company.rawValue)
        userDetailsTableView.delegate = userDetailsTableView
        userDetailsTableView.dataSource = userDetailsTableView
        userDetailsTableView.content = self.user
        userDetailsTableView.onPress = { (type) in
            switch type {
            case .email:
                if let url = self.user.emailURL {
                    UIApplication.shared.open(url)
                }
            case .address:
                let vc = MapViewController(address: self.user.address)
                self.navigationController?.pushViewController(vc, animated: true)
            case .phone:
                if let url = self.user.phoneURL {
                    UIApplication.shared.open(url)
                }
            case .website:
                if let url = self.user.websiteURL {
                    UIApplication.shared.open(url)
                }
            default:
                break
            }
        }
        
    }
    
}
