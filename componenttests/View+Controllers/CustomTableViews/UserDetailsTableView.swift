//
//  UserDetailsTableView.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit

class UserDetailsTableView: UITableView {
    
    enum ReuseIdentifiers: String {
        case id = "UserIdCell"
        case name = "UserNameCell"
        case username = "UserUsernameCell"
        case email = "UserEmailCell"
        case address = "UserAddressCell"
        case phone = "UserPhoneCell"
        case website = "UserWebsiteCell"
        case company = "UserCompanyCell"
    }
    
    var content: UserViewModel!
    var onPress: (UserContentType) -> Void = { (_) in }
}

extension UserDetailsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = UserContentType(rawValue: indexPath.row) else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch type {
        case .email:
            if self.content.canSendEmail() { self.onPress(type) }
        case .address:
            self.onPress(type)
        case .phone:
            if self.content.canCall() { self.onPress(type) }
        case .website:
            if self.content.canAccessBrowser() { self.onPress(type) }
        default:
            break
        }
    }
}

extension UserDetailsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { UserContentType.allCases.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = UserContentType(rawValue: indexPath.row) else { return UITableViewCell() }
        var cell: UITableViewCell = UITableViewCell()
        var contentConfiguration: UIListContentConfiguration!
        
        switch type {
        case .id:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.id.rawValue, for: indexPath)
            cell.selectionStyle = .none
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "number")
            contentConfiguration.text = self.content.id.description
            contentConfiguration.secondaryText = "Id"
        case .name:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.name.rawValue, for: indexPath)
            cell.selectionStyle = .none
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "textformat.size.larger")
            contentConfiguration.text = self.content.name
            contentConfiguration.secondaryText = "Name"
        case .username:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.username.rawValue, for: indexPath)
            cell.selectionStyle = .none
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "signature")
            contentConfiguration.text = self.content.username
            contentConfiguration.secondaryText = "Username"
        case .email:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.email.rawValue, for: indexPath)
            cell.accessoryType = self.content.canSendEmail() ? .disclosureIndicator : .none
            cell.selectionStyle = self.content.canSendEmail() ? .default : .none
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "mail")
            contentConfiguration.text = self.content.email
            contentConfiguration.secondaryText = "Email"
        case .address:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.address.rawValue, for: indexPath)
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "house")
            contentConfiguration.text = self.content.address.street
            contentConfiguration.secondaryText = "Address"
            cell.accessoryType = .disclosureIndicator
        case .phone:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.phone.rawValue, for: indexPath)
            cell.accessoryType = self.content.canCall() ? .disclosureIndicator : .none
            cell.selectionStyle = self.content.canCall() ? .default : .none
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "phone")
            contentConfiguration.text = self.content.phoneWithFormat
            contentConfiguration.secondaryText = "Phone"
        case .website:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.website.rawValue, for: indexPath)
            cell.accessoryType = self.content.canAccessBrowser() ? .disclosureIndicator : .none
            cell.selectionStyle = self.content.canAccessBrowser() ? .default : .none
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "globe.americas")
            contentConfiguration.text = self.content.website.description
            contentConfiguration.secondaryText = "Website"
        case .company:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.company.rawValue, for: indexPath)
            contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.image = UIImage(systemName: "cart")
            contentConfiguration.text = self.content.company.name
            contentConfiguration.secondaryText = "Company"
        }
        
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}
