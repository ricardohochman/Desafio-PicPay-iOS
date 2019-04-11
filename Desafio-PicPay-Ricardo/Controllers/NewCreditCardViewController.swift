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
}
