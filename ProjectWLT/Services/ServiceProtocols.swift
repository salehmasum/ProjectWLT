//
//  ServiceProtocols.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 2/7/18.
//  Copyright © 2018 Selise. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol: APIProtocol
{
    func loginRequest(withCredentials payload: Login.InitiateLogIn.Request, completionHandler: @escaping (LoginResponseModel?, Error?) -> Void )
}

protocol LoginProtocol: APIProtocol {
    func loginRequest(withCredentials payload: Login.InitiateLogIn.Request, completionHandler: @escaping (User?, Error?) -> Void )
}

protocol APIProtocol {
    
}
