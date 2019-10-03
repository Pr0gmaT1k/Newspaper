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
    fileprivate static let keychainService = KeychainService(serviceType: Environment.Newspaper.appName)
    fileprivate static let networkStack = NetworkStack(baseURL: Environment.Newspaper.baseURL,
                                                       keychainService: keychainService)
    
    private static let emailKey = "email"
    private static let pwdKey = "password"
    
    // MARK: - Services
    func auth(email: String, pwd: String) -> Observable<Auth?> {
        let requestParameters = RequestParameters(method: .post, route: NPRoute.signIn, parameters: [NPWebServiceClient.emailKey: email, NPWebServiceClient.pwdKey: pwd])
        
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> Auth? in
            print("\(json)")
            return Mapper<Auth>().map(JSONObject: json)
        }
    }
}
