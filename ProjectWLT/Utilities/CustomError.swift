//
//  CustomError.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 11/13/17.
//  Copyright © 2017 Selise. All rights reserved.
//

import Foundation

enum APIError: Error {
  case networkError
  case noInternetConnectionError
  case validationError(reason: String)
  case authenticationError
  case internalServerError
  case resourceNotFoundError
  case serviceError
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .noInternetConnectionError:
            return "No internet connection. Please check your network."
        case .validationError(let reason):
            return "Validation error reason: \(reason)"
        case .authenticationError:
            return "Authentication error"
        case .internalServerError:
            return "Internal server error"
        case .resourceNotFoundError:
            return "Resource not found error"
        default:
            return "Other network error"
        }
    }
    
}
