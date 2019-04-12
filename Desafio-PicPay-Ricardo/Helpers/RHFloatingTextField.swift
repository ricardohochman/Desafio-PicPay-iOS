//
//  RHFloatingTextField.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class RHFloatingTextField: UITextField {
    var enableMaterialPlaceHolder = true
    var lblPlaceHolder = UILabel()
    var defaultFont = UIFont()
    var difference: CGFloat = 22.0
    var underLine = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.enableMaterialPlaceHolder(enableMaterialPlaceHolder: true)
        underLine = UIImageView()
        underLine.backgroundColor = UIColor.gray
        underLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        
        underLine.clipsToBounds = true
        self.addSubview(underLine)
        defaultFont = self.font!
    }
    
    @IBInspectable var placeHolderColor: UIColor? = UIColor.lightGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
    @IBInspectable var underLineColor: UIColor = UIColor.lightGray {
        didSet {
            setup()
        }
    }
    
    override public var placeholder: String? {
        willSet {
            let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: UIFont.labelFontSize]
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes: atts)
            self.enableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
        }
    }
    
    override public var attributedText: NSAttributedString? {
        willSet {
            if (self.placeholder != nil) && (self.text != "") {
                let string = NSString(string: self.placeholder!)
                self.placeholderText(string)
            }
            
        }
    }
    
    @objc func textFieldDidChange() {
        if self.enableMaterialPlaceHolder {
            if (self.text == nil) || (self.text?.count)! > 0 {
                self.lblPlaceHolder.alpha = 1
                self.attributedPlaceholder = nil
                self.lblPlaceHolder.textColor = self.placeHolderColor
                self.lblPlaceHolder.frame.origin.x = 0
                let fontSize = self.font!.pointSize
                self.lblPlaceHolder.font = UIFont(name: (self.font?.fontName)!, size: fontSize - 3)
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
                if (self.text == nil) || (self.text?.count)! <= 0 {
                    self.lblPlaceHolder.font = self.defaultFont
                    self.lblPlaceHolder.frame = CGRect(x: self.lblPlaceHolder.frame.origin.x, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                } else {
                    self.lblPlaceHolder.frame = CGRect(x: self.lblPlaceHolder.frame.origin.x, y: -self.difference, width: self.frame.size.width, height: self.frame.size.height)
                }
            })
        }
    }
    
    func enableMaterialPlaceHolder(enableMaterialPlaceHolder: Bool) {
        self.enableMaterialPlaceHolder = enableMaterialPlaceHolder
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height)
        self.lblPlaceHolder.font = UIFont.systemFont(ofSize: 10)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
    }
    
    func placeholderText(_ placeholder: NSString) {
        let atts = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.labelFontSize] as [NSAttributedString.Key: Any]
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String, attributes: atts)
        self.enableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
    }
    
    override public func becomeFirstResponder() -> Bool {
        let returnValue = super.becomeFirstResponder()
        self.lblPlaceHolder.textColor = placeHolderColor
        self.underLine.backgroundColor = underLineColor
        return returnValue
    }

    override public func resignFirstResponder() -> Bool {
        let returnValue = super.resignFirstResponder()
        self.lblPlaceHolder.textColor = UIColor.gray
        self.underLine.backgroundColor = UIColor.gray
        return returnValue
    }
}
