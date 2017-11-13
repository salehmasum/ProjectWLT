//
//  WPAuthenticationService.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 11/8/17.
//  Copyright © 2017 Selise. All rights reserved.
//

import Foundation
import Alamofire

class WPAuthenticationService: AuthenticationProtocol
{
  func loginRequest(withCredentials payload: Login.InitiateLogIn.Request, completionHandler: @escaping (LoginResponseModel?, Error?) -> Void )
  {
    let userId = payload.userId
    let password = payload.password
    let parameter: Parameters = ["email":userId, "password": password]
    Alamofire.request(WPRouter.register(parameters: parameter)).responseData { response in
      //
      debugPrint(response)
      switch response.result {
      case .success(let value):
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200..<300:
            do{
              let loginResponseModel = try JSONDecoder().decode(LoginResponseModel.self, from: value)
              completionHandler(loginResponseModel, nil)
            }catch(let error) {
              completionHandler(nil, error)
            }
          case 400..<500:
            completionHandler(nil, APIError.validationError(reason: "error description"))
          case 500..<600:
            completionHandler(nil, APIError.internalServerError)
          default:
            completionHandler(nil, APIError.serviceError)
          }
        }
      case .failure(let error):
        if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
          completionHandler(nil, APIError.noInternetConnectionError)
        }
        else {
          completionHandler(nil, APIError.networkError)
        }
      }
      //
    }
  }
}

