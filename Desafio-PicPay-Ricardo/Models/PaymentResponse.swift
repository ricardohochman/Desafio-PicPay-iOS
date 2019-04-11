//
//  PaymentResponse.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 11/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

struct PaymentResponse: Codable {
    let transaction: Transaction
}

struct Transaction: Codable {
    let id: Int?
    let timestamp: Int?
    let value: Double?
    let success: Bool?
    let status: String?
}

/*
{
    "transaction": {
        "id": 12314,
        "timestamp": 1555022910,
        "value": 79.9,
        "destination_user": {
            "id": 1002,
            "name": "Marina Coelho",
            "img": "https://randomuser.me/api/portraits/women/37.jpg",
            "username": "@marina.coelho"
        },
        "success": true,
        "status": "Aprovada"
    }
}
*/
