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
    fileprivate static let keychainService = KeychainService(serviceType: Environment.TestApp.appName)
    fileprivate static let networkStack = NetworkStack(baseURL: Environment.TestApp.baseURL,
                                                       keychainService: keychainService)
    
    
    // Mark:- Services
    
}
