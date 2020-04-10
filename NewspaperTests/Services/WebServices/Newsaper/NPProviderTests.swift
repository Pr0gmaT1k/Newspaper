//
//  NPProviderTests.swift
//  NewspaperTests
//
//  Created by azerty on 23/11/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
import Moya
@testable import Newspaper

final class NPProviderTests: XCTestCase {
    // MARK: - Properties
    private let provider: MoyaProvider<NPProvider> = MoyaProvider<NPProvider>(stubClosure: MoyaProvider.immediatelyStub)
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        didAnswer = expectation(description: "WS response")
    }
    
    func testSignIn() {
        var response: Auth?
        provider.request(.signIn(email: "a", pwd: "a")) { result in
            if case let .success(auth) = result {
//                response = try JSONDecoder().decode(auth.
            }
        }
    }
}
