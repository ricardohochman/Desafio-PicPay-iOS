//
//  CreditCardSpecs.swift
//  Desafio-PicPay-RicardoTests
//
//  Created by Ricardo Hochman on 12/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Quick
import Nimble
@testable import RPay

class CreditCardSpecs: QuickSpec {
    
    override func spec() {
        describe("The Credit Card validation") {
            context("With a valid credit card") {
                let creditCard = CreditCard(number: "5401056009927563", name: "Ricardo", expiracy: "12/25", cvv: "123", brand: "Mastercard")
                it("verify correct number") {
                    expect(CreditCardManager.isValidCardNumber(with: creditCard.number!)).to(beTrue())
                }
                it("verify the brand") {
                    expect(CreditCardManager.cardType(for: creditCard.number!)?.name).to(equal(creditCard.brand!))
                }
            }
            
            context("With an invalid credit card") {
                let creditCard = CreditCard(number: "1000000000000000", name: "Ricardo", expiracy: "12/25", cvv: "123", brand: "")
                it("can identify an error") {
                    expect(CreditCardManager.isValidCardNumber(with: creditCard.number!)).to(beFalse())
                }
                it("verify the brand") {
                    expect(CreditCardManager.cardType(for: creditCard.number!)?.name).to(beNil())
                }
            }
        }
    }
}
