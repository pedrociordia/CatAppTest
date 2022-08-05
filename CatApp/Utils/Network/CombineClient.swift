//
//  CombineClient.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation
import Combine

 class CombineClient: CombineClientProtocol {
    
     var session: URLSession
    
     init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
     }
    
     convenience init() {
         self.init(configuration: .default)
     }
     
     func fetchAllCatBreeds() -> AnyPublisher<[CatBreedsModel], CustomError> {
         execute(.breeds, decodingType: [CatBreedsModel].self)
     }
    
     func fetchCatBreedsByName(_ name: String) -> AnyPublisher<[CatBreedsDetailModel], CustomError> {
        execute(.breedsByName(name), decodingType: [CatBreedsDetailModel].self)
    }
     
     func loginUser(_ login: LoginModel) -> Bool {
         return Endpoint.login(login).request as? Bool ?? false
     }
}
