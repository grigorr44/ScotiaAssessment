//
//  Transaction.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

struct Transaction: Identifiable, Equatable, Hashable {
    let id: String
    let type: TransactionType
    let merchantName: String
    let description: String?
    let amount: Decimal
    let currency: String
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String
}
