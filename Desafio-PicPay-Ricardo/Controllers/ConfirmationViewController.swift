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
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var changeCardButton: UIButton!
    @IBOutlet private weak var payButton: RHButton!
    
    // MARK: - Actions
    @IBAction private func changeCreditCard() {
        self.performSegue(withIdentifier: R.segue.confirmationViewController.goToEditCreditCard, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueVC = R.segue.confirmationViewController.goToEditCreditCard(segue: segue) {
            segueVC.destination.paymentFlowViewModel = paymentFlowViewModel
        }
    }
    
    @IBAction private func pay() {
        guard let priceText = priceTextField.text else { return }
        let price = Double(priceText.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        paymentFlowViewModel?.setValue(value: price)
        showActivityIndicator()
        paymentFlowViewModel?.pay { [weak self] success in
            guard let self = self else { return }
            self.removeActivityIndicator()
            if success {
                // TODO: Show success
            } else {
                self.showAlert(message: "Falha no pagamento", title: "Tente novamente com outro cartão de crédito")
            }
        }
    }
    
    // MARK: - Variables
    var paymentFlowViewModel: PaymentFlowViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationGreenBack()
        setupInfo()
    }
    
    private func setupTextField() {
        priceTextField.attributedPlaceholder = NSAttributedString(string: "0,00", attributes: [.foregroundColor: AppColors.gray])
    }
    
    private func setupInfo() {
        userImageView.setImage(with: paymentFlowViewModel?.image)
        usernameLabel.text = paymentFlowViewModel?.username
        changeCardButton.setAttributedTitle(paymentFlowViewModel?.changeCardButtonTitle, for: .normal)
        checkViewState()
        priceTextField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDidChange() {
        checkViewState()
        if let amountString = priceTextField.text?.currencyInputFormatting() {
            priceTextField.text = amountString
        }
    }
    
    private func checkViewState() {
        let active = priceTextField.text != "0,0" && !(priceTextField.text?.isEmpty ?? false)
        if active {
            currencyLabel.textColor = AppColors.green
            payButton.backgroundColor = AppColors.green
            payButton.isEnabled = true
        } else {
            currencyLabel.textColor = AppColors.gray
            payButton.backgroundColor = AppColors.gray
            payButton.isEnabled = false
        }
    }
}
