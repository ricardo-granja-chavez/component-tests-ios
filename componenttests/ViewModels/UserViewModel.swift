//
//  UserViewModel.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import Foundation

// MARK: - User
struct UserViewModel {
    private let user: UserModel!
    
    var id: Int { self.user.id ?? 0 }
    var name: String { self.user.name ?? "" }
    var username: String { self.user.username ?? "" }
    var email: String { self.user.email ?? "" }
    var phone: String { self.user.phone ?? "" }
    var website: String { self.user.website ?? "" }
    
    let address: AddressViewModel!
    let company: CompanyViewModel!
    
    init(user: UserModel) {
        self.user = user
        self.address = AddressViewModel(address: self.user.address ?? AddressModel())
        self.company = CompanyViewModel(company: self.user.company ?? CompanyModel())
    }
}

// MARK: - User List
struct UserListViewModel {
    private var users: [UserModel] = []
    
    var count: Int { self.users.count }
    
    init(users: [UserModel]) {
        self.users = users.sorted(by: { UserViewModel(user: $0).name < UserViewModel(user: $1).name })
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
