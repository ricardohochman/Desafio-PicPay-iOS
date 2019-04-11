//
//  PaymentFlowViewModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class PaymentFlowViewModel {
    
    // MARK: - Constants
    private let api: MainAPI
    
    // MARK: - Variables
    private var paymentModel = PaymentModel()
    private var user: User?
    var card: CreditCard?
    var response: PaymentResponse?
    
    // MARK: - Init
    init(api: MainAPI = MainAPI()) {
        self.api = api
    }
    
    // MARK: - Parameters
    
    var hasCard: Bool {
        return card != nil
    }
    
    var savedCard: CreditCard? {
        return CreditCardPersistenceManager.shared.getCard()
    }
    
    var username: String {
        return user?.username ?? ""
    }
    
    var image: URL? {
        return URL(string: user?.img ?? "")
    }
    
    var changeCardButtonTitle: NSMutableAttributedString {
        let brand = card?.brand ?? ""
        let cardNumber = card?.number ?? ""
        let lastFour = String(cardNumber.suffix(4))
        
        let cardTitle = "\(brand) \(lastFour) • "
        let editString = "EDITAR"
        let mainString = "\(cardTitle)\(editString)"
        
        let range = (mainString as NSString).range(of: editString)
        let attribute = NSMutableAttributedString(string: mainString)
        attribute.addAttribute(.foregroundColor, value: UIColor.white, range: (mainString as NSString).range(of: cardTitle))
        attribute.addAttribute(.foregroundColor, value: AppColors.green, range: range)
        return attribute
    }
    
    // MARK: - Set Info
    func setUser(user: User) {
        self.user = user
        paymentModel.setUserInfo(user: user)
    }
    
    func setCreditCard(card: CreditCard) {
        self.card = card
        CreditCardPersistenceManager.shared.deleteCard()
        CreditCardPersistenceManager.shared.createCard(card)
        paymentModel.setCreditCardInfo(card: card)
    }
    
    func setValue(value: Double) {
        paymentModel.setValue(value: value)
    }
    
    func pay(completion: @escaping (Bool) -> Void) {
        api.pay(payment: paymentModel) { result in
            switch result {
            case .success(let response):
                self.response = response
                if response.transaction.success == true {
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(let err):
                print("Falha no pagamento", err)
                completion(false)
            }
        }
    }
}
