//
//  OWWebServiceClient.swift
//  Meteo
//
//  Created by Julien CLOUPET on 10/11/2017.
//  Copyright © 2017 Pr0g. All rights reserved.
//

import JWTDecode
import KeychainAccess
import Moya

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
            switch result {
            case let .success(response):
                do {
                    let auth = try response.filterSuccessfulStatusAndRedirectCodes().map(Auth.self)
                    guard let token = auth.token else { return }
                    NPWebServiceClient.keychainService[JSONKeys.authorisation] = token
                    NPWebServiceClient.keychainService[JSONKeys.tokenExp] = try? JWTDecode.decode(jwt: token).body[JSONKeys.tokenExp] as? String
                    completion?()
                } catch let error { print(NPWebServiceClient.decodeError(error: error as? MoyaError) as Any) }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func register(name: String, lastname: String, dni: String, email: String, pwd: String, pwdConfimation: String, completion: (() -> Void)? = nil) throws {
        NPProvider.provider.request(.signUp(name: name, lastname: lastname, dni: dni, email: email, pwd: pwd, pwdConfimation: pwdConfimation)) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusAndRedirectCodes()
                    completion?()
                } catch let error { print(NPWebServiceClient.decodeError(error: error as? MoyaError) as Any) }
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    static func getCurrentUser(completion: ((User) -> Void)? = nil) throws {
        
        let token = NPWebServiceClient.keychainService[JSONKeys.authorisation] ?? "empty"
        let userId: Int = (try? JWTDecode.decode(jwt: token))?.body[JSONKeys.tokenUserID] as? Int ?? 00
        // Error will be returned by the WS if param is empty.
        
        NPProvider.provider.request(.user(userId: userId)) { result in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                    let userJson = (try filteredResponse.mapJSON() as? [String: Any])?[JSONKeys.user]
                    let data = try JSONSerialization.data(withJSONObject: userJson as Any)
                    completion?(try NPWebServiceClient.decode(data) as User)
                } catch let error { print(NPWebServiceClient.decodeError(error: error as? MoyaError) as Any) }
            case let .failure(error): print(error.localizedDescription) }
        }
    }
    
    static func getUsers(completion: ((Users) -> Void)? = nil) throws {
        NPProvider.provider.request(.users) { result in
            switch result {
            case let .success(response):
                do {
                    completion?(try response.filterSuccessfulStatusAndRedirectCodes().map(Users.self))
                } catch let error { print(NPWebServiceClient.decodeError(error: error as? MoyaError) as Any) }
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    static func createPost(title: String, description: String?, body: String?, completion: (() -> Void)? = nil) throws {
        NPProvider.provider.request(.createPost(title: title, description: description, body: body)) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusAndRedirectCodes()
                    completion?()
                } catch let error { print(NPWebServiceClient.decodeError(error: error as? MoyaError) as Any) }
                completion?()
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    static func getPosts(completion: ((Posts) -> Void)? = nil) throws {
        NPProvider.provider.request(.posts) { result in
            switch result {
            case let .success(response):
                do {
                    completion?(try response.filterSuccessfulStatusAndRedirectCodes().map(Posts.self))
                } catch let error { print(NPWebServiceClient.decodeError(error: error as? MoyaError) as Any) }
            case let .failure(error): print(error.localizedDescription)
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
    
    static private func decodeError(error: MoyaError?) -> String? {
        guard let error = error else { return nil }
        return try? error.response?.map(NPError.self).message
    }
}
