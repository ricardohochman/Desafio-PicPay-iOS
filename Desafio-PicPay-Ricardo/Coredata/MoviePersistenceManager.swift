//
//  MoviePersistenceManager.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import CoreData

class CreditCardPersistenceManager: CoreDataManager {
    
    internal typealias T = CreditCardPersistence
    
    static let shared = CreditCardPersistenceManager()
        
    func createCard(_ card: CreditCard) {
        self.newEntity().fromObject(card)
        self.saveContext()
    }
    
    func getCard() -> CreditCard? {
        guard let cardsPersistence = self.fetchData() else { return nil }
        return cardsPersistence.map { CreditCard(fromPersistence: $0) }.first
    }
    
    func deleteCard() {
        guard let cardsPersistence = self.fetchData() else { return }
        self.delete(cardsPersistence)
    }
}
