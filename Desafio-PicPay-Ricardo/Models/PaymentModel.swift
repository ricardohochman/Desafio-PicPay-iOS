//
//  PaymentModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

struct PaymentModel: Codable {
    var cardNumber: String?
    var cvv: Int?
    var value: Double?
    var expiryDate: String?
    var userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case cvv
        case value
        case expiryDate = "expiry_date"
        case userId = "destination_user_id"
    }
    
    mutating func setCreditCardInfo(card: CreditCard) {
        self.cardNumber = card.number?.replacingOccurrences(of: " ", with: "")
        self.cvv = Int(card.cvv ?? "")
        self.expiryDate = card.expiracy
    }
    
    mutating func setUserInfo(user: User) {
        self.userId = user.id
    }
    
    mutating func setValue(value: Double) {
        self.value = value
    }
}

/*
 {
    "card_number":"1111111111111111",
    "cvv":789,
    "value":79.9,
    "expiry_date":"01/18",
    "destination_user_id":1002
 }
 */
