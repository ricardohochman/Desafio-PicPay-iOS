//
//  PaymentFlowViewModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

class PaymentFlowViewModel {
    
    // MARK: - Variables
    var paymentModel = PaymentModel()
    private var user: User?
    private var card: CreditCard?
    
    // MARK: - Parameters
    
    var username: String {
        return user?.username ?? ""
    }
    
    private var cardTitle: String {
        let brand = card?.brand ?? ""
        let cardNumber = card?.number ?? ""
        let lastFour = String(cardNumber.suffix(4))
        return "\(brand) \(lastFour) • "
    }
    
    private var editString: String {
        return "EDITAR"
    }
    
    private var mainString: String {
        return "\(cardTitle)\(editString)"
    }
    
    var cardAttributedTitle: NSMutableAttributedString {
        let range = (mainString as NSString).range(of: editString)
        let attribute = NSMutableAttributedString(string: mainString)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.green, range: range)
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
