//
//  TransactionDTO+Mapper.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

extension TransactionDTO {
    func toDomain() -> Transaction {
        Transaction(
            id: key,
            type: transactionType.toDomain(),
            merchantName: merchantName,
            description: description,
            amount: amount.value,
            currency: amount.currency,
            postedDate: postedDate,
            fromAccount: fromAccount,
            fromCardNumber: fromCardNumber
        )
    }
}

private extension TransactionTypeDTO {
    func toDomain() -> TransactionType {
        switch self {
        case .credit:
            return .credit
        case .debit:
            return .debit
        }
    }
}
