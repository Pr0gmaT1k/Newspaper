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
import JWTDecode
import ObjectMapper

final class NPWebServiceClient {
    // MARK: - Properties
    private static let keychainService = KeychainService(serviceType: Environment.Newspaper.appName)
    private static let networkStack = NetworkStack(baseURL: Environment.Newspaper.baseURL, keychainService: keychainService)
    public static var isLogged: Bool {
        return self.keychainService.accessToken != nil
            && self.keychainService.expirationInterval ?? 0 > Date().timeIntervalSince1970 
    }
    
    // MARK: - Services
    func auth(email: String, pwd: String) -> Observable<Void> {
        let requestParameters = RequestParameters(method: .post, route: NPRoute.signIn, parameters: [JSONKeys.email: email, JSONKeys.pwd: pwd])
        
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> Void in
            let auth = Mapper<Auth>().map(JSONObject: json)
            guard let token = auth?.token else { return }
            NPWebServiceClient.keychainService.accessToken = token
            NPWebServiceClient.keychainService.expirationInterval = (try? decode(jwt: token))?.body[JSONKeys.tokenExp] as? Double
        }
    }
    
    func register(name: String,
                  lastname: String,
                  dni: String,
                  email: String,
                  pwd: String,
                  pwdConfimation: String) -> Observable<Void> {
        let requestParameters = RequestParameters(method: .post, route: NPRoute.signUp, parameters: [JSONKeys.user: [JSONKeys.dni: dni, JSONKeys.name: name, JSONKeys.lastName: lastname, JSONKeys.email: email, JSONKeys.pwd: pwd, JSONKeys.pwdConfirmation: pwdConfimation]])
        
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> Void in
            let auth = Mapper<Auth>().map(JSONObject: json)
            NPWebServiceClient.keychainService.accessToken = auth?.token
        }
    }
    
    func user()-> Observable<User?> {
        let token = NPWebServiceClient.keychainService.accessToken ?? "empty"
        let userId: Int = (try? decode(jwt: token))?.body[JSONKeys.tokenUserID] as? Int ?? 00
        // Error will be returned by the WS if param is empty.
        let requestParameters = RequestParameters(method: .get, route: NPRoute.user(userId: userId), headers: [JSONKeys.authorisation: token])
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> User? in
            let userJson = (json as? [String: Any])?[JSONKeys.user]
            return Mapper<User>().map(JSONObject: userJson)
        }
    }
    
    func users() {
        
    }
    
    func createPost(title: String, description: String?, body: String?) -> Observable<Void> {
        let token = NPWebServiceClient.keychainService.accessToken ?? "empty"
        let params = [JSONKeys.post: [JSONKeys.postTitle: title, JSONKeys.postDescription: (description ?? ""), JSONKeys.postBody: (body ?? "")]]
        let requestParameters = RequestParameters(method: .post, route: NPRoute.posts, parameters: params, headers: [JSONKeys.authorisation: token])
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, _) -> Void in
            // Whatever ....
        }
    }
    
    func getPosts() -> Observable<Posts?> {
        let token = NPWebServiceClient.keychainService.accessToken ?? "empty"
        let requestParameters = RequestParameters(method: .get, route: NPRoute.posts, headers: [JSONKeys.authorisation: token])
        return NPWebServiceClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters).map { (_, json) -> Posts? in
            return Mapper<Posts>().map(JSONObject: json)
        }
    }
    
    func disconnect() {
        NPWebServiceClient.keychainService.accessToken = nil
        NPWebServiceClient.keychainService.expirationInterval = nil
    }
}
