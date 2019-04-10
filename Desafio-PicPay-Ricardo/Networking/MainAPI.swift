//
//  MainAPI.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Alamofire

class MainAPI {
    
    let requestManager: RequestManager
    
    init(requestManager: RequestManager = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func getUsers(completion: @escaping (Result<[User]>) -> Void) {
        guard let url = URL(string: "http://careers.picpay.com/tests/mobdev/users") else {
            fatalError("Invalid URL")
        }
        
        requestManager.requestArray(url: url, method: .get, parameters: [:], headers: [:], completion: completion)
    }
}
