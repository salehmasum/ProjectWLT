//
//  WPRouter.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 11/8/17.
//  Copyright © 2017 Selise. All rights reserved.
//

import Foundation
import Alamofire

enum WPRouter: URLRequestConvertible {
  
  case usersList(parameters: Parameters)
  case create(parameters: Parameters)
  case update(parameters: Parameters)
  case register(parameters: Parameters)
  
  static let baseURLString = "https://reqres.in"
  
  var method: HTTPMethod {
    switch self {
      
    case .register:
      return .post
    case .update:
      return .put
    case .create:
      return .post
    case .usersList:
      return .get
      
    }
  }
  
  var path: String {
    switch self {
      
    case .register:
      return "/api/register"
    case .update:
      return "/api/users/2"
    case .create:
      return "/api/users"
    case .usersList:
      return "/api/users"
      
    }
  }
  
  // MARK: URLRequestConvertible
  
  func asURLRequest() throws -> URLRequest {
    let url = try WPRouter.baseURLString.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    
    switch self {
    case .register(let parameters):
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    case .update(let parameters):
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    case .create(let parameters):
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    case .usersList(let parameters):
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
      //    default:
      //      break
    }
    
    return urlRequest
  }
}

enum AdditionalRouter: URLRequestConvertible {
  
  case newusersList(parameters: Parameters)
  case getPhotos
  
  static let baseURLString = "http://jsonplaceholder.typicode.com"
  
  var method: HTTPMethod {
    switch self {
      
    case .newusersList, .getPhotos:
      return .get
      
    }
  }
  
  var path: String {
    switch self {
      
    case .newusersList:
      return "/api/users"
    case .getPhotos:
      return "/photos"
      
    }
  }
  
  // MARK: URLRequestConvertible
  
  func asURLRequest() throws -> URLRequest {
    let url = try AdditionalRouter.baseURLString.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    
    switch self {
    case .newusersList(let parameters):
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    default:
      break
    }
    
    return urlRequest
  }
}
