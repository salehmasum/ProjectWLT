//
//  LoginService.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 2/7/18.
//  Copyright © 2018 Selise. All rights reserved.
//

import Foundation
import Alamofire

class LoginService: LoginProtocol
{
    func loginRequest(withCredentials payload: Login.InitiateLogIn.Request, completionHandler: @escaping (User?, Error?) -> Void )
    {
        Alamofire.request(APIRouter.login(email: payload.userId, password: payload.password)).responseData { response in
            //
            debugPrint(response)
            switch response.result {
            case .success(let value):
                if let httpStatusCode = response.response?.statusCode {
                    switch (httpStatusCode) {
                    case 200..<300:
                        do{
                            let user = try JSONDecoder().decode(User.self, from: value)
                            completionHandler(user, nil)
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
