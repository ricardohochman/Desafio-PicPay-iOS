//
//  UserTableViewCell.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import AlamofireImage
import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(viewModel: UserViewModel) {
        if let url = viewModel.image {
            mainImageView.af_setImage(withURL: url)
        }
        usernameLabel.text = viewModel.username
        nameLabel.text = viewModel.name
    }
}
