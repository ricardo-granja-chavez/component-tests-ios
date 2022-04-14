//
//  UserViewModel.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit

enum UserContentType: Int, CaseIterable {
    case id
    case name
    case username
    case email
    case address
    case phone
    case website
    case company
}

// MARK: - User
struct UserViewModel {
    private let user: UserModel!
    
    var id: Int { self.user.id ?? 0 }
    var name: String { self.user.name ?? "" }
    var username: String { self.user.username ?? "" }
    var email: String { self.user.email?.lowercased() ?? "" }
    var emailURL: URL? { URL(string: "mailto:\(self.email)") }
    private var phone: String { self.user.phone ?? "" }
    var phonePlain: String {
        let elements = self.phone.split(separator: " ")
        guard let onlyPhone = elements.first?.description else { return "" }
        var phonePlain = ""
        
        for char in onlyPhone {
            if let number = Int(char.description) {
                phonePlain.append(number.description)
            }
        }
        
        if phonePlain.count > 10 {
            while phonePlain.count > 10 {
                phonePlain.removeFirst()
            }
        }
        
        return phonePlain
    }
    var phoneWithFormat: String {
        let string: NSMutableString = NSMutableString(string: self.phonePlain)
        string.insert("-", at: 6)
        string.insert("-", at: 3)
        string.insert(")", at: 3)
        string.insert("(", at: 0)
        return string.description
    }
    var phoneURL: URL? { URL(string: "tel://\(self.phonePlain)") }
    var website: String { self.user.website ?? "" }
    var websiteURL: URL? { URL(string: "https://www.\(self.website)") }
    
    let address: AddressViewModel!
    let company: CompanyViewModel!
    
    init(user: UserModel) {
        self.user = user
        self.address = AddressViewModel(address: self.user.address ?? AddressModel())
        self.company = CompanyViewModel(company: self.user.company ?? CompanyModel())
    }
    
    /* This function only enters a great effect on physical device */
    public func canSendEmail() -> Bool { self.emailURL != nil }
    
    public func canCall() -> Bool { self.emailURL != nil }
    
    public func canAccessBrowser() -> Bool { self.websiteURL != nil }
}

// MARK: - User List
struct UserListViewModel {
    private var users: [UserModel] = []
    
    var count: Int { self.users.count }
    
    init(users: [UserModel]) {
        self.users = users.sorted(by: { UserViewModel(user: $0).id < UserViewModel(user: $1).id })
    }
    
    public func userForIndex(_ index: Int) -> UserViewModel { UserViewModel(user: self.users[index]) }
}

// MARK: - Address
struct AddressViewModel {
    private let address: AddressModel!
    
    var street: String { self.address.street ?? "" }
    var suite: String { self.address.suite ?? "" }
    var city: String { self.address.city ?? "" }
    var zipcode: String { self.address.zipcode ?? "" }
    
    let geo: GeoViewModel!
    
    init(address: AddressModel) {
        self.address = address
        self.geo = GeoViewModel(geo: self.address.geo ?? GeoModel())
    }
}

// MARK: - Geo
struct GeoViewModel {
    private let geo: GeoModel!
    
    var lat: String { self.geo.lat ?? "" }
    var lng: String { self.geo.lng ?? "" }
    
    init(geo: GeoModel) {
        self.geo = geo
    }
}

// MARK: - Company
struct CompanyViewModel {
    private let company: CompanyModel!
    
    var name: String { self.company.name ?? "" }
    var catchPhrase: String { self.company.catchPhrase ?? "" }
    var bs: String { self.company.bs ?? "" }
    
    init(company: CompanyModel) {
        self.company = company
    }
}
