//
//  UserModel.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import Foundation

// MARK: - User
struct UserModel: Codable {
    var id: Int? = nil
    var name: String? = nil
    var username: String? = nil
    var email: String? = nil
    var address: AddressModel? = nil
    var phone: String? = nil
    var website: String? = nil
    var company: CompanyModel? = nil
}

// MARK: - Address
struct AddressModel: Codable {
    var street: String? = nil
    var suite: String? = nil
    var city: String? = nil
    var zipcode: String? = nil
    var geo: GeoModel? = nil
}

// MARK: - Geo
struct GeoModel: Codable {
    var lat: String? = nil
    var lng: String? = nil
}

// MARK: - Company
struct CompanyModel: Codable {
    var name: String? = nil
    var catchPhrase: String? = nil
    var bs: String? = nil
}
