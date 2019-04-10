//
//  Dictionary+Extensions.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

extension Dictionary {
    static func += (lhs: inout Dictionary, rhs: Dictionary) {
        lhs.merge(rhs) { _, new in new }
    }
}
