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

extension CreditCard {
    init(fromPersistence card: CreditCardPersistence) {
        self.init(number: card.number, name: card.name, expiracy: card.expiracy, cvv: card.cvv, brand: card.brand)
    }
}

extension CreditCardPersistence {
    func fromObject(_ card: CreditCard) {
        self.number = card.number
        self.name = card.name
        self.expiracy = card.expiracy
        self.cvv = card.cvv
        self.brand = card.brand
    }
}
