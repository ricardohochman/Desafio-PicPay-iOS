//
//  RHTextField.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 12/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

@IBDesignable
class RHTextField: UITextField {
    
    @IBInspectable
    var cornerRadius: CGFloat = 8.0 {
        didSet {
            if cornerRadius != 0 {
                layer.cornerRadius = self.cornerRadius
                self.clipsToBounds = true
            }
        }
    }
    
    @IBInspectable
    var hasBorder: Bool = true {
        didSet {
            if hasBorder {
                self.layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .black {
        didSet {
            if hasBorder {
                self.layer.borderColor = borderColor.cgColor
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
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        if changeLeftPadding {
            textRect.origin.x += leftPadding
        }
        return textRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        if changeLeftPadding {
            textRect.origin.x += leftPadding
        }
        return textRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.editingRect(forBounds: bounds)
        if changeLeftPadding {
            textRect.origin.x += leftPadding
        }
        return textRect
    }
    
    @IBInspectable
    var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var leftPadding: CGFloat = 4
    
    @IBInspectable
    var changeLeftPadding: Bool = false
    
    private func updateView() {
        let placeHolderColor = self.tintColor.withAlphaComponent(0.8)
        
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = self.tintColor
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
    }
    
    var isEmpty: Bool {
        if let auxText = self.text, auxText.isEmpty {
            self.shake()
            return true
        }
        return false
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -8.0, 8.0, -7.0, 7.0, -4.0, 4.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
