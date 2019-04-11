//
//  PayFooterTableViewCell.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class PayFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var saveButton: RHButton!
    
    func hideButton() {
        saveButton.isHidden = true
    }
    
}
