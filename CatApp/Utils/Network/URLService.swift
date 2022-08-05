//
//  URLService.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation

class URLService {
    
    func get(_ path: String) -> URLRequest? {
        guard let url = URL(string: "https://api.thecatapi.com/v1/\(path)") else {
            return nil
        }
        
        return setURLRequest(url)
    }
    
    func query(_ param: String) -> URLRequest? {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds/search?q=\(param)") else {
            return nil
        }
        
        return setURLRequest(url)
    }
    
    func loginUser(login: LoginModel) -> Bool {
        
        let email = Bundle.main.infoDictionary!["EMAIL_LOGIN"] as! String
        let password = Bundle.main.infoDictionary!["PASSWORD_LOGIN"] as! String
        
        if login.email == email && login.password == password {
            return true
        }
        
        return false
    }
    
    private func setURLRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("x-api-key", forHTTPHeaderField: "\(Bundle.main.infoDictionary!["API_CLIENT"] as! String)")
        
        return request
    }
}
