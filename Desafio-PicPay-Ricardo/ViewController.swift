//
//  ViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getUsers { users, err in
            users?.forEach { print($0.name ?? "") }
        }
    }
}
