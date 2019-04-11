//
//  ConfirmationViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var changeCardButton: UIButton!
    @IBOutlet weak var payButton: RHButton!
    
    // MARK: - Actions
    @IBAction func changeCreditCard() {
        self.performSegue(withIdentifier: R.segue.confirmationViewController.goToEditCreditCard, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueVC = R.segue.confirmationViewController.goToEditCreditCard(segue: segue) {
            segueVC.destination.paymentFlowViewModel = paymentFlowViewModel
        }
    }
    
    @IBAction func pay() {
    }
    
    // MARK: - Variables
    var paymentFlowViewModel: PaymentFlowViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationGreenBack()
        setupInfo()
    }
    
    private func setupInfo() {
        self.userImageView.setImage(with: paymentFlowViewModel?.image)
        self.usernameLabel.text = paymentFlowViewModel?.username
        self.changeCardButton.setAttributedTitle(paymentFlowViewModel?.changeCardButtonTitle, for: .normal)
    }
}
