//
//  NewCreditCardViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class NewCreditCardViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var numberTextField: RHFloatingTextField!
    @IBOutlet private weak var nameTextField: RHFloatingTextField!
    @IBOutlet private weak var expireTextField: RHFloatingTextField!
    @IBOutlet private weak var cvvTextField: RHFloatingTextField!
    
    // MARK: - Variables
    private var footerView: PayFooterTableViewCell?
    var paymentFlowViewModel: PaymentFlowViewModel?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createFooter()
        setupInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationGreenBack()
        checkFields()
    }
    
    // MARK: - Actions
    @IBAction func editingChanged(_ sender: RHFloatingTextField) {
        checkFields()
        switch sender {
        case numberTextField:
            sender.maskCreditCard()
        case nameTextField:
            break
        case expireTextField:
            sender.maskValidityCard()
        case cvvTextField:
            sender.maskCvvCard()
        default:
            break
        }
    }
    
    private func createFooter() {
        footerView = R.nib.payFooterTableViewCell(owner: nil)
        footerView?.delegate = self
    }
    
    private func setupInfo() {
        if paymentFlowViewModel?.hasCard ?? false {
            self.numberTextField.text = paymentFlowViewModel?.card?.number
            self.nameTextField.text = paymentFlowViewModel?.card?.name
            self.expireTextField.text = paymentFlowViewModel?.card?.expiracy
            self.cvvTextField.text = paymentFlowViewModel?.card?.cvv
        }
    }
    
    private func checkFields() {
        if !(numberTextField.text?.isEmpty ?? true) &&
            !(nameTextField.text?.isEmpty ?? true) &&
            isValidExpiracy() &&
            isValidCvv() {
            showFooter(true)
        } else {
            showFooter(false)
        }
    }
    
    // MARK: - Helpers
    private func isValidCardNumber() -> Bool {
        return CreditCardManager.isValidCardNumber(with: numberTextField.text ?? "")
    }
    
    private func isValidExpiracy() -> Bool {
        if let text = expireTextField.text {
            return text.onlyNumbers().count >= 4
        }
        return false
    }
    
    private func isValidCvv() -> Bool {
        if let text = cvvTextField.text {
            return text.onlyNumbers().count >= 3
        }
        return false
    }
    
    private func showFooter(_ value: Bool) {
        if value {
            if self.tableView.tableFooterView == nil {
                self.tableView.tableFooterView = self.footerView
                self.tableView.tableFooterView?.alpha = 0.0
                UIView.animate(withDuration: 0.25) {
                    self.tableView.tableFooterView?.alpha = 1.0
                }
            }
        } else {
            if self.tableView.tableFooterView != nil {
                UIView.animate(withDuration: 0.25, animations: {
                    self.tableView.tableFooterView?.alpha = 0.0
                }, completion: { _ in
                    self.tableView.tableFooterView = nil
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueVC = R.segue.newCreditCardViewController.goToConfirmation(segue: segue) {
            segueVC.destination.paymentFlowViewModel = paymentFlowViewModel
        }
    }
}

extension NewCreditCardViewController: PayFooterDelegate {
    func pay() {
//        if !isValidCardNumber() {
//            showAlert(message: "Número do cartão de crédito inválido")
//            return
//        }
        
        let number = numberTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let expiracy = expireTextField.text ?? ""
        let cvv = cvvTextField.text ?? ""
        let brand = CreditCardManager.cardType(for: number) ?? .mastercard
        
        let creditCard = CreditCard(number: number, name: name, expiracy: expiracy, cvv: cvv, brand: brand.name)
        
        if paymentFlowViewModel?.hasCard ?? false {
            paymentFlowViewModel?.setCreditCard(card: creditCard)
            self.navigationController?.popViewController(animated: true)
        } else {
            paymentFlowViewModel?.setCreditCard(card: creditCard)
            self.performSegue(withIdentifier: R.segue.newCreditCardViewController.goToConfirmation, sender: nil)
        }
    }
}
