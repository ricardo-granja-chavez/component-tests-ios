//
//  UserRoute.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import Foundation

enum UserRouter: APIConfiguration {
    case getUsers
    
    internal var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .GET
        }
    }
    
    internal var parameters: Data? {
        switch self {
        case .getUsers:
            return nil
        }
    }
    
    public func toRequest() -> URLRequest {
        let url = URL(string: APIManager.shared.baseURL + self.path)!
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.httpBody = self.parameters
        request.allHTTPHeaderFields = APIManager.shared.headers
        return request
    }
}
