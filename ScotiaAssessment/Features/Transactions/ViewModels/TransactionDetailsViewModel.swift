//
//  TransactionDetailsViewModel.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import Foundation
import Observation

@MainActor
@Observable
final class TransactionDetailsViewModel {
    // MARK: Properties

    private let transaction: Transaction

    var title: String {
        switch transaction.type {
        case .credit:
            return "Credit transaction"
        case .debit:
            return "Debit transaction"
        }
    }

    var transactionType: TransactionType {
        transaction.type
    }

    var transactionFrom: String {
        transaction.fromAccount
    }

    var lastFourDigitsFormatted: String {
        "(\(transaction.fromCardNumber.lastFourDigits))"
    }

    var amountText: String {
        transaction.amount.formatted(.currency(code: transaction.currency))
    }

    // MARK: Initialization

    init(transaction: Transaction) {
        self.transaction = transaction
    }
}


