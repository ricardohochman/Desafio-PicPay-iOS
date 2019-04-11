//
//  CreditCardManager.swift
//  Jumpers
//
//  Created by 005_FVFX21BGJ1WV on 06/03/19.
//  Copyright © 2019 Outsmart. All rights reserved.
//

import Foundation

enum CreditCardManager {
    
    public enum CreditCardType: String, CaseIterable {
        case amex
        case diners
        case elo
        case mastercard = "master"
        case visa
        
        var name: String {
            switch self {
            case .amex:
                return "Amex"
            case .diners:
                return "Diners"
            case .elo:
                return "Elo"
            case .mastercard:
                return "Mastercard"
            case .visa:
                return "Visa"
            }
        }
    }
    
    private static func regularExpression(for cardType: CreditCardType) -> String {
        switch cardType {
        case .amex:
            return "^3[47][0-9]{5,}$"
        case .diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        case .mastercard:
            return "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
        case .visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        }
    }
    
    static func isValidCardNumber(with cardNumber: String) -> Bool {
        
        let formattedCardNumber = cardNumber.onlyNumbers()
        
        guard formattedCardNumber.count >= 9 else {
            return false
        }
        
        guard let originalCheckDigit = formattedCardNumber.last else { return false }
        let characters = formattedCardNumber.dropLast().reversed()
        
        var digitSum = 0
        
        for (idx, character) in characters.enumerated() {
            let value = Int(String(character)) ?? 0
            if idx % 2 == 0 {
                var product = value * 2
                
                if product > 9 {
                    product -= 9
                }
                
                digitSum += product
            } else {
                digitSum += value
            }
        }
        
        digitSum *= 9
        
        let computedCheckDigit = digitSum % 10
        
        let originalCheckDigitInt = Int(String(originalCheckDigit))
        let valid = originalCheckDigitInt == computedCheckDigit
        
        return valid
    }
    
    static func cardType(for cardNumber: String) -> CreditCardType? {
        var foundCardType: CreditCardType?
        
        for cardType in CreditCardType.allCases {
            let regex = regularExpression(for: cardType)
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            if predicate.evaluate(with: cardNumber.onlyNumbers()) == true {
                foundCardType = cardType
                break
            }
        }
        
        return foundCardType
    }
}
