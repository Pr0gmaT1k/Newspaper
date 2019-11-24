//
//  NPProviderSampleData.swift
//  Newspaper
//
//  Created by azerty on 23/11/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

struct NPSampleData {
    // MARK:- Encoder
    static let encoder = JSONEncoder()
    
    // MARK:- Public Obect
    static let user = User(id: 1, created_at: "", dni: "", email: "", lastname: "", name: "", password_digest: "", updated_at: "")
    static let post = Post(id: 1, body: "", created_at: "", postDescription: "", title: "", updated_at: "", user_id: 1)
    static let auth = Auth(exp: "", message: "", status: true, token: "test.test.test")
    static let users = Users(status: true, users: [NPSampleData.user])
    static let posts = Posts(status: true, posts: [NPSampleData.post])
    
    // MARK:- Public encoded
    static let encodedUser = (try? NPSampleData.encoder.encode(NPSampleData.user)) ?? Data()
    static let encodedPost = (try? NPSampleData.encoder.encode(NPSampleData.post)) ?? Data()
    static let encodedAuth = (try? NPSampleData.encoder.encode(NPSampleData.auth)) ?? Data()
    static let encodedusers = (try? NPSampleData.encoder.encode(NPSampleData.users)) ?? Data()
    static let encodedPosts = (try? NPSampleData.encoder.encode(NPSampleData.posts)) ?? Data()
}
