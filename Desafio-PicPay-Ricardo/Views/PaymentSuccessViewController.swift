//
//  PaymentSuccessViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class PaymentSuccessViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var creditCardNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: - Variables
    var viewModel: PaymentFlowViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfo()
    }
    
    private func setupInfo() {
        userImageView.setImage(with: viewModel?.image)
        usernameLabel.text = viewModel?.username
        
        let timestamp = viewModel?.response?.transaction.timestamp ?? 0
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        let dateString = formatter.string(from: date)
        dateLabel.text = dateString
        
        transactionLabel.text = "Transação: \(viewModel?.response?.transaction.id ?? 0)"
        
        let brand = viewModel?.card?.brand ?? ""
        let cardNumber = viewModel?.card?.number ?? ""
        let lastFour = String(cardNumber.suffix(4))
        let cardTitle = "Cartão \(brand) \(lastFour) "
        creditCardNameLabel.text = cardTitle

        let priceDouble = viewModel?.response?.transaction.value ?? 0.0
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.numberStyle = .currency
        if let formattedPrice = numberFormatter.string(from: priceDouble as NSNumber) {
            priceLabel.text = formattedPrice
            totalPriceLabel.text = formattedPrice
        }

    }
}
