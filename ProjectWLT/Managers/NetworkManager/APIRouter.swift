//
//  APIRouter.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 2/7/18.
//  Copyright © 2018 Selise. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case login(email:String, password:String)
    case articles
    case article(id: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .articles, .article:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return NetworkConstants.login
        case .articles:
            return NetworkConstants.articles
        case .article(let id):
            return "\(NetworkConstants.article)/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [NetworkConstants.APIParameterKey.email: email, NetworkConstants.APIParameterKey.password: password]
        case .articles, .article:
            return nil
        }
    }
    
    // MARK: - Headers
    var headers: HTTPHeaders {
        var headers : [String:String] = [:]
        switch self {
        case .login:
            headers[HTTPHeaderField.acceptType.rawValue] = ContentType.json.rawValue
        default:
            headers[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
            //set authorization token if available
            break
        }
        return headers
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.allHTTPHeaderFields = headers
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        //Alternative approach
        // return try URLEncoding.methodDependent.encode(urlRequest, with: parameters)
        
        return urlRequest
    }
}
