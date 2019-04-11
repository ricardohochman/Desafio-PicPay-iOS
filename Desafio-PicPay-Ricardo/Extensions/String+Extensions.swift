//
//  String+Extensions.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

extension String {
    
    func onlyNumbers() -> String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    mutating public func maskCreditCard() {
        self.mask("****  ****  ****  ****")
    }
    
    mutating public func mask(_ format: String!) {
        let replacementChar: Character = "*"
        
        if !self.isEmpty && !format.isEmpty {
            
            let tempString = self
            
            var finalText = ""
            var stop = false
            
            var formatterIndex = format.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                let formattingPatternRange = (formatterIndex)..<(format.index(formatterIndex, offsetBy: 1))
                
                if format[formattingPatternRange] != String(replacementChar) {
                    finalText.append(String(format[formattingPatternRange]))
                } else if !tempString.isEmpty {
                    let pureStringRange = (tempIndex)..<(tempString.index(tempIndex, offsetBy: 1))
                    finalText.append(String(tempString[pureStringRange]))
                    tempIndex = tempString.index(tempIndex, offsetBy: 1)
                }
                
                formatterIndex = format.index(formatterIndex, offsetBy: 1)
                
                if formatterIndex >= format.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
            }
            self = finalText
        }
    }
}
