//
//  CatBreedsModel.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation

struct CatBreedsModel : Codable {
    var id: String?
    var name: String?
    var description: String?
    var origin: String?
    var image: Image?
    
    struct Image : Codable {
        var id: String
        var url: String
    }
}
