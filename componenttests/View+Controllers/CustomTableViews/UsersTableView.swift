//
//  UsersTableView.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit

class UsersTableView: UITableView {
    var collection: UserListViewModel!
    var onPress: (UserViewModel) -> Void = { (_) in }
}

extension UsersTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.collection.userForIndex(indexPath.row)
        self.onPress(user)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.collection != nil ? self.collection.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let user = self.collection.userForIndex(indexPath.row)
        cell.textLabel?.text = user.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
