//
//  OWWebServiceClient.swift
//  Meteo
//
//  Created by Julien CLOUPET on 10/11/2017.
//  Copyright © 2017 Pr0g. All rights reserved.
//

import RxSwift
import Alamofire
import NetworkStack
import ObjectMapper

final class NPWebServiceClient {
    // MARK: - Properties
    private static let keychainService = KeychainService(serviceType: Environment.Newspaper.appName)
    private static let networkStack = NetworkStack(baseURL: Environment.Newspaper.baseURL, keychainService: keychainService)
    public static var isLogged: Bool {
        // TODO: Verify is the token is expired
        //return self.keychainService.accessToken != nil
        return false
    }
    
    // MARK: - Services
    func auth(email: String, pwd: String) -> Observable<Void> {
        let requestParameters = RequestParameters(method: .post, route: NPRoute.signIn, parameters: [JSONKeys.email: email, JSONKeys.pwd: pwd])
        
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> Void in
            let auth = Mapper<Auth>().map(JSONObject: json)
            NPWebServiceClient.keychainService.accessToken = auth?.token
        }
    }
    
    func register(name: String,
                  lastname: String,
                  dni: String,
                  email: String,
                  pwd: String,
                  pwdConfimation: String) -> Observable<Void> {
        let requestParameters = RequestParameters(method: .post, route: NPRoute.signUp, parameters: [JSONKeys.dni: dni, JSONKeys.name: name, JSONKeys.lastName: lastname, JSONKeys.email: email, JSONKeys.pwd: pwd, JSONKeys.pwdConfirmation: pwdConfimation])
        
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> Void in
            let auth = Mapper<Auth>().map(JSONObject: json)
            NPWebServiceClient.keychainService.accessToken = auth?.token
        }
    }
}
