//
//  NotificationCenterManager.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let paymentSuccess = Notification.Name("paymentSuccess")
}

class NotificationCenterManager {
    
    static func showPaymentSuccess(viewModel: PaymentFlowViewModel) {
        NotificationCenter.default.post(name: .paymentSuccess, object: nil, userInfo: ["payment": viewModel])
    }
    
    static func retrievePaymentSuccess(_ notification: Notification) -> PaymentFlowViewModel? {
        if let viewModel = notification.userInfo?["payment"] as? PaymentFlowViewModel {
            return viewModel
        }
        return nil
    }
}
