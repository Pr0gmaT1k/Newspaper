//
//  OpenWeatherRoute.swift
//  Meteo
//
//  Created by Julien CLOUPET on 10/11/2017.
//  Copyright © 2017 Pr0g. All rights reserved.
//
//
import Moya
import KeychainAccess

public enum NewspaperMoya: TargetType {
    case signIn(email: String, pwd: String)
    case signUp(name: String, lastname: String, dni: String, email: String, pwd: String, pwdConfimation: String)
    case users
    case user(userId: Int)
    case post(postId: Int64)
    case posts
    case createPost(title: String, description: String?, body: String?)
    
    private static let keychainService = Keychain(service: Environment.Newspaper.appName)
    private static var token: String { NewspaperMoya.keychainService[JSONKeys.authorisation] ?? "empty" }
    private static let authPlugin = AccessTokenPlugin { token }
    
    public var baseURL: URL { URL(string: Environment.Newspaper.baseURL)! }
    static let provider = MoyaProvider<Self>(plugins: [NewspaperMoya.authPlugin])
    
    public var path: String {
        switch self {
        case .signIn: return "/user/signin"
        case .signUp: return "/user/signup"
        case .users: return "/user"
        case .user(userId: let userId): return "/user/\(userId)"
        case .post(postId: let postId): return "/post/\(postId)"
        case .posts, .createPost: return "/post/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .createPost: return .post
        default: return .get
        }
    }
    
    public var sampleData: Data {
        return "to implement to use test".data(using: .utf8) ?? Data()
    }
    
    public var task: Task {
        switch self {
        case .signIn(email: let email, pwd: let pwd):
            return .requestParameters(parameters: [JSONKeys.email: email, JSONKeys.pwd: pwd],
                                      encoding: URLEncoding.default)
        case .signUp(name: let name,
                    lastname: let lastname,
                    dni: let dni,
                    email: let email,
                    pwd: let pwd,
                    pwdConfimation: let pwdConfimation):
            return .requestParameters(parameters: [JSONKeys.user: [JSONKeys.dni: dni, JSONKeys.name: name, JSONKeys.lastName: lastname, JSONKeys.email: email, JSONKeys.pwd: pwd, JSONKeys.pwdConfirmation: pwdConfimation]], encoding: URLEncoding.default)
        case .createPost(title: let title, description: let description, body: let body):
            return .requestParameters(parameters: [JSONKeys.post: [JSONKeys.postTitle: title,
                                                   JSONKeys.postDescription: description ?? "",
                                                   JSONKeys.postBody: body ?? ""]], encoding: URLEncoding.default)
        default: return .requestPlain
        }
    }
    
    public var headers: [String: String]? { nil }
}

extension NewspaperMoya: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType {
        switch self {
        case .signIn, .signUp: return .none
        default: return .bearer
        }
    }
}
