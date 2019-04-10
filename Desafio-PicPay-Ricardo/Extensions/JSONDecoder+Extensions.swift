//
//  JSONDecoder+Extensions.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, fromDict dict: [AnyHashable: Any]) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return try self.decode(type, from: data)
    }
    
    func decode<T>(_ type: T.Type, fromArray array: [[AnyHashable: Any]]) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        return try self.decode(type, from: data)
    }
}
