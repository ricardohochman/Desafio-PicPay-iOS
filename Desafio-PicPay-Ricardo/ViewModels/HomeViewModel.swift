//
//  HomeViewModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

class HomeViewModel {
    
    let api: MainAPI
    
    init(api: MainAPI = MainAPI()) {
        self.api = api
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        api.getUsers { result in
            switch result {
            case .success(let users):
                completion(users, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
