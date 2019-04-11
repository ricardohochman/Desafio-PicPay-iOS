//
//  NewCreditCardViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class NewCreditCardViewController: UITableViewController {

    @IBOutlet private weak var numberTextField: RHFloatingTextField!
    @IBOutlet private weak var nameTextField: RHFloatingTextField!
    @IBOutlet private weak var expireTextField: RHFloatingTextField!
    @IBOutlet private weak var cvvTextField: RHFloatingTextField!
    
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
            print("mostra o salvar")
        } else {
            guard let footer = self.tableView(tableView, viewForFooterInSection: 0) as? PayFooterTableViewCell else { return }
            footer.hideButton()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = R.nib.payFooterTableViewCell(owner: nil) else { return nil }
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
