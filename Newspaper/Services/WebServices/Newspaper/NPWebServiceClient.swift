//
//  OWWebServiceClient.swift
//  Meteo
//
//  Created by Julien CLOUPET on 10/11/2017.
//  Copyright © 2017 Pr0g. All rights reserved.
//

import JWTDecode
import KeychainAccess

struct NPWebServiceClient {
    // MARK: - Properties
    static let keychainService = Keychain(service: Environment.Newspaper.appName)
    public static var isLogged: Bool {
        guard let token = self.keychainService[JSONKeys.authorisation] else { return false }
        return (try? JWTDecode.decode(jwt: token).expired == false) ?? false
    }
    
    // MARK: - Services
    static func signIn(email: String, pwd: String, completion: (() -> Void)? = nil) throws {
        NPProvider.provider.request(.signIn(email: email, pwd: pwd)) { result in
            if case let .success(response) = result {
                let auth = try? NPWebServiceClient.decode(response.data) as Auth
                guard let token = auth?.token else { return }
                NPWebServiceClient.keychainService[JSONKeys.authorisation] = token
                NPWebServiceClient.keychainService[JSONKeys.tokenExp] = try? JWTDecode.decode(jwt: token).body[JSONKeys.tokenExp] as? String
                completion?()
            }
        }
    }
    
    static func register(name: String, lastname: String, dni: String, email: String, pwd: String, pwdConfimation: String, completion: (() -> Void)? = nil) throws {
        NPProvider.provider.request(.signUp(name: name, lastname: lastname, dni: dni, email: email, pwd: pwd, pwdConfimation: pwdConfimation)) { result in
            if case .success(_) = result {
                completion?()
            }
        }
    }
    
    static func getCurrentUser(completion: ((User?) -> Void)? = nil) throws {
        
        let token = NPWebServiceClient.keychainService[JSONKeys.authorisation] ?? "empty"
        let userId: Int = (try? JWTDecode.decode(jwt: token))?.body[JSONKeys.tokenUserID] as? Int ?? 00
        // Error will be returned by the WS if param is empty.
        
        NPProvider.provider.request(.user(userId: userId)) { result in
            if case let .success(response) = result,
                let userJson = (try? response.mapJSON() as? [String: Any])?[JSONKeys.user],
                let data = try? JSONSerialization.data(withJSONObject: userJson) {
                completion?(try? self.decode(data) as User)
            }
        }
    }
    
    static func getUsers(completion: ((Users?) -> Void)? = nil) throws {
        NPProvider.provider.request(.users) { result in
            if case let .success(response) = result {
                completion?(try? self.decode(response.data) as Users)
            }
        }
    }
    
    static func createPost(title: String, description: String?, body: String?, completion: (() -> Void)? = nil) throws {
        NPProvider.provider.request(.createPost(title: title, description: description, body: body)) { result in
            if case .success(_) = result {
                completion?()
            }
        }
    }
    
    static func getPosts(completion: ((Posts?) -> Void)? = nil) throws {
        NPProvider.provider.request(.posts) { result in
            if case let .success(response) = result {
                completion?(try? self.decode(response.data) as Posts)
            }
        }
    }
    
    static func disconnect() {
        NPWebServiceClient.keychainService[JSONKeys.authorisation] = nil
        NPWebServiceClient.keychainService[JSONKeys.tokenExp] = nil
    }
    
    static private func decode<T>(_ data: Data, type: T.Type = T.self) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
