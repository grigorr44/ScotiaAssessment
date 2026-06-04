//
//  TransactionDTO.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

struct TransactionDTO: Decodable {
    let key: String
    let transactionType: TransactionTypeDTO
    let merchantName: String
    let description: String?
    let amount: AmountDTO
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String

    enum CodingKeys: String, CodingKey {
        case key
        case transactionType = "transaction_type"
        case merchantName = "merchant_name"
        case description
        case amount
        case postedDate = "posted_date"
        case fromAccount = "from_account"
        case fromCardNumber = "from_card_number"
    }
}
