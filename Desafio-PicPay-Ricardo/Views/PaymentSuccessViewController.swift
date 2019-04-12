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
    var viewModel: PaymentSuccessViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfo()
    }
    
    private func setupInfo() {
        userImageView.setImage(with: viewModel?.image)
        usernameLabel.text = viewModel?.username
        dateLabel.text = viewModel?.date
        transactionLabel.text = viewModel?.transaction
        creditCardNameLabel.text = viewModel?.cardTitle
        priceLabel.text = viewModel?.priceFormatted
        totalPriceLabel.text = viewModel?.priceFormatted
    }
}
