//
//  PayFooterTableViewCell.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

protocol PayFooterDelegate: class {
    func pay()
}

class PayFooterTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var saveButton: RHButton!
    
    // MARK: - Variables
    weak var delegate: PayFooterDelegate?
    
    // MARK: - Actions
    @IBAction private func saveAction() {
        delegate?.pay()
    }
}
