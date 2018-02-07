//
//  BackendAuth.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 2/7/18.
//  Copyright © 2018 Selise. All rights reserved.
//

// This class should encapsulate backendAuthToken functions

import Foundation
public final class BackendAuth {
    
    private let key = NetworkConstants.backendAuthToken
    private let defaults: UserDefaults
    
    public static var shared: BackendAuth!
    
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    public func setToken(token: String) {
        defaults.setValue(token, forKey: key)
    }
    
    public var token: String? {
        return defaults.value(forKey: key) as? String
    }
    
    public func deleteToken() {
        defaults.removeObject(forKey: key)
    }
}



