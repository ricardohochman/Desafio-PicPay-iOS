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
    
    // MARK: - Constants
    private let footer = R.nib.payFooterTableViewCell(owner: nil)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
    
    private func checkFields() {
        if !(numberTextField.text?.isEmpty ?? true) &&
            !(nameTextField.text?.isEmpty ?? true) &&
            !(expireTextField.text?.isEmpty ?? true) &&
            !(cvvTextField.text?.isEmpty ?? true) {
            showFooter(true)
        } else {
            showFooter(false)
        }
    }
    
    private func showFooter(_ value: Bool) {
        if value {
            if self.tableView.tableFooterView == nil {
                self.tableView.tableFooterView = self.footer
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
}
