//
//  AuthenticationWorker.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 11/8/17.
//  Copyright © 2017 Selise. All rights reserved.
//

import Foundation

class AuthenticationWorker
{
  var authenticationService: AuthenticationProtocol
  
  init(authenticationService: AuthenticationProtocol)
  {
      self.authenticationService = authenticationService
  }
  
  func initiateLoginProcess(withCredentials payload: Login.InitiateLogIn.Request, completionHandler: @escaping (LoginResponseModel?, Error?) -> Void ) {
    self.authenticationService.loginRequest(withCredentials: payload) { (responseObject, error) in
      
      completionHandler(responseObject, error)
      
    }
  }
  
}


protocol AuthenticationProtocol
{
  func loginRequest(withCredentials payload: Login.InitiateLogIn.Request, completionHandler: @escaping (LoginResponseModel?, Error?) -> Void )
}
