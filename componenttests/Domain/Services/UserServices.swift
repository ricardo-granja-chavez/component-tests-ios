//
//  UserService.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import Foundation

class UserServices {
    static var shared: UserServices { UserServices() }
    
    func getUsers(completion: @escaping (Result<[UserModel], APIError>) -> Void) {
        APIManager.shared.request(url: UserRouter.getUsers.toRequest(), completion: completion)
    }
}
