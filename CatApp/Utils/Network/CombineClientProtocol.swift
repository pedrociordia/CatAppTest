//
//  CombineClientProtocol.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation
import Combine

protocol CombineClientProtocol {
    
    var session: URLSession { get }
}

extension CombineClientProtocol {
    
    func execute<T>(_ request: Endpoint, decodingType: T.Type, queue: DispatchQueue = .main) -> AnyPublisher<T, CustomError> where T: Decodable {
        guard let request = request.request as? URLRequest else {
            return Fail(error: CustomError.invalidRequestError).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .mapError({ error in
                return CustomError.custom(error: error)
            })
            .eraseToAnyPublisher()
    }
}
