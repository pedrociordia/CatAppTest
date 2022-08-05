//
//  Endpoint.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation

enum Endpoint {
    case breeds
    case breedsByName(_ name: String)
    case login(_ login: LoginModel)
}

extension Endpoint {
    var request: Any? {
        switch self {
        case .breeds:
            return URLService().get("breeds")
        case .breedsByName(let name):
            return URLService().query(name)
        case .login(let login):
            return URLService().loginUser(login: login)
        }
    }
}
