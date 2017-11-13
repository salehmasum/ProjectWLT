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
}
