//
//  DesignableView.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

@IBDesignable
class RHButton: UIButton {
    
    enum LayoutType {
        case bordered
        case full
    }
    
    var type: LayoutType = .full
    
    @IBInspectable
    var clipping: Bool {
        get {
            return clipsToBounds
        }
        set {
            clipsToBounds = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var hasBorder: Bool = true {
        didSet {
            if hasBorder {
                self.layer.borderColor = self.tintColor.cgColor
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1.0 {
        didSet {
            if hasBorder {
                self.layer.borderWidth = self.borderWidth
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.layer.borderColor = isEnabled ? self.tintColor.cgColor : self.tintColor.withAlphaComponent(0.5).cgColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if type == .bordered {
                self.layer.backgroundColor = isHighlighted ? self.tintColor.cgColor : UIColor.clear.cgColor
            }
        }
    }
}
