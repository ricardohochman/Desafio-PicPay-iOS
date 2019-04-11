//
//  CreditCard.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

struct CreditCard: Codable {
    var number: String?
    var name: String?
    var expiracy: String?
    var cvv: String?
    var brand: String?
}
