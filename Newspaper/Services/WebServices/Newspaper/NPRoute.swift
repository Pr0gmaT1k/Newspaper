//
//  OpenWeatherRoute.swift
//  Meteo
//
//  Created by Julien CLOUPET on 10/11/2017.
//  Copyright © 2017 Pr0g. All rights reserved.
//
//
//import NetworkStack
//
//public enum NPRoute: Routable {
//    case signIn
//    case signUp
//    case users
//    case user(userId: Int)
//    case post(postId: Int64)
//    case posts
//
//    public var path: String {
//        switch self {
//        case .signIn: return "/user/signin"
//        case .signUp: return "/user/signup"
//        case .users: return "/user"
//        case .user(userId: let userId): return "/user/\(userId)"
//        case .post(postId: let postId): return "/post/\(postId)"
//        case .posts: return "/post/"
//        }
//    }
//}

import UIKit
import Moya

public enum NewspaperMoya: TargetType {
    case signIn
    case signUp
    case users
    case user(userId: Int)
    case post(postId: Int64)
    case posts
    
    public var baseURL: URL { return URL(string: Environment.Newspaper.baseURL)! }
    static let provider = MoyaProvider<Self>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    public var path: String {
        switch self {
        case .signIn: return "/user/signin"
        case .signUp: return "/user/signup"
        case .users: return "/user"
        case .user(userId: let userId): return "/user/\(userId)"
        case .post(postId: let postId): return "/post/\(postId)"
        case .posts: return "/post/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signIn, .signUp: return .post
        default: return .get
        }
    }
    
    public var sampleData: Data {
        return "to implement to use test".data(using: .utf8) ?? Data()
    }
    
    public var task: Task { return .requestPlain }
    
    public var headers: [String: String]? {
        return nil
    }
    
    private func decode<T>(_ data: Data, type: T.Type = T.self) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}


import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let gitHubProvider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum GitHub {
    case zen
    case userProfile(String)
    case userRepositories(String)
}

extension GitHub: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }
    public var path: String {
        switch self {
        case .zen:
            return "/zen"
        case .userProfile(let name):
            return "/users/\(name.urlEscaped)"
        case .userRepositories(let name):
            return "/users/\(name.urlEscaped)/repos"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .userRepositories:
            return .requestParameters(parameters: ["sort": "pushed"], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    public var validationType: ValidationType {
        switch self {
        case .zen:
            return .successCodes
        default:
            return .none
        }
    }
    public var sampleData: Data {
        switch self {
        case .zen:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .userRepositories(let name):
            return "[{\"name\": \"\(name)\"}]".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
