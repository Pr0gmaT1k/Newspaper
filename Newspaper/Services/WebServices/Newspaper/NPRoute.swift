//
//  OpenWeatherRoute.swift
//  Meteo
//
//  Created by Julien CLOUPET on 10/11/2017.
//  Copyright © 2017 Pr0g. All rights reserved.
//

import NetworkStack

public enum NPRoute: Routable {
    case signIn
    case signUp
    case users
    case user(userId: Int)
    case post(postId: Int64)
    case posts
    
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
}
