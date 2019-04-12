//
//  PaymentSuccessViewModel.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

class PaymentSuccessViewModel {
    
    // MARK: - Variables
    var viewModel: PaymentFlowViewModel
    
    init(viewModel: PaymentFlowViewModel) {
        self.viewModel = viewModel
    }
    
    var username: String {
        return viewModel.username
    }
    
    var image: URL? {
        return viewModel.image
    }
    
    var date: String {
        let timestamp = viewModel.response?.transaction.timestamp ?? 0
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    var transaction: String {
        return "Transação: \(viewModel.response?.transaction.id ?? 0)"
    }
    
    var cardTitle: String {
        let brand = viewModel.card?.brand ?? ""
        let cardNumber = viewModel.card?.number ?? ""
        let lastFour = String(cardNumber.suffix(4))
        let cardTitle = "Cartão \(brand) \(lastFour) "
        return cardTitle
    }
    
    var priceFormatted: String {
        let priceDouble = viewModel.response?.transaction.value ?? 0.0
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: priceDouble as NSNumber) ?? ""
    }
    
}
