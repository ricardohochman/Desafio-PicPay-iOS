//
//  CreditCardOnboardingViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class CreditCardOnboardingViewController: UIViewController {

    var paymentFlowViewModel: PaymentFlowViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationGreenBack()
    }
    
    @IBAction func goToNewCreditCard() {
        self.performSegue(withIdentifier: R.segue.creditCardOnboardingViewController.goToNewCreditCard, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueVC = R.segue.creditCardOnboardingViewController.goToNewCreditCard(segue: segue) {
            segueVC.destination.paymentFlowViewModel = paymentFlowViewModel
        }
    }
}
