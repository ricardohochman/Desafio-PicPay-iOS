//
//  HomeViewModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Constants
    private let api: MainAPI
    
    // MARK: - Variables
    private var users = [UserViewModel]()
    
    // MARK: - Init
    init(api: MainAPI = MainAPI()) {
        self.api = api
    }
    
    // MARK: - API
    func getUsers(completion: @escaping (Error?) -> Void) {
        api.getUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.users = users.map { UserViewModel(user: $0) }
                completion(nil)
            case .failure(let err):
                completion(err)
            }
        }
    }
    
    // MARK: - Data Source
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func user(at index: Int) -> UserViewModel {
        return users[index]
    }
}

class UserViewModel {
    
    // MARK: - Constants
    private let user: User
    
    // MARK: - Init
    init(user: User) {
        self.user = user
    }
    
    // MARK: - Parameters
    var username: String {
        return user.username ?? ""
    }
    
    var name: String {
        return user.name ?? ""
    }
    
    var image: URL? {
        return URL(string: user.img ?? "")
    }
}
