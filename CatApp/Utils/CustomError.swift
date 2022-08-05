//
//  CustomError.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation

enum CustomError: LocalizedError {
    case custom(error: Error)
    case invalidRequestError
    case string(msm: String)
    
    var errorDescription: String? {
        switch self {
        case .custom(let error):
            return error.localizedDescription
        case .invalidRequestError:
            return "Invalid Request"
        case .string(let msm):
            return msm
        }
    }
}
