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
    
    func setImage(with url: URL?) {
        guard let url = url else { return }
        self.af_setImage(withURL: url, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false)
    }

}
