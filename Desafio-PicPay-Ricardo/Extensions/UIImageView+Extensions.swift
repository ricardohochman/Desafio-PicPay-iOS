//
//  UIImageView+Extensions.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import AlamofireImage
import UIKit

extension UIImageView {
    
    func setImageWithPlaceholder(with URL: URL) {
        self.af_setImage(withURL: URL, placeholderImage: #imageLiteral(resourceName: "moviePlaceholder"), imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false)
    }
    
    func setImage(with URL: URL) {
        self.af_setImage(withURL: URL, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false)
    }

}
