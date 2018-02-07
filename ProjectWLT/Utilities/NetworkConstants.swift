//
//  NetworkConstants.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 2/7/18.
//  Copyright © 2018 Selise. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let baseUrl = "http://itechnodev.com/api"
    static let login = "/login"
    static let articles = "/articles/all.json"
    static let article = "/article"
    static let backendAuthToken = "BackendAuthToken"
    
    struct APIParameterKey {
        static let password = "password"
        static let email    = "email"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}


