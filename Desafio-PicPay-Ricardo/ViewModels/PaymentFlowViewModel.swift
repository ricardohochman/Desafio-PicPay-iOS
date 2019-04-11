//
//  PaymentFlowViewModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class PaymentFlowViewModel {
    
    // MARK: - Variables
    private var paymentModel = PaymentModel()
    private var user: User?
    var card: CreditCard?
    
    // MARK: - Parameters
    
    var hasCard: Bool {
        return card != nil
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
        paymentModel.setCreditCardInfo(card: card)
    }
    
    func setValue(value: Double) {
        paymentModel.setValue(value: value)
    }
    
}
