//
//  TransactionDetailsViewModelTest.swift
//  ScotiaAssessmentTests
//
//  Created by Grigor Grigoryan on 2026-06-05.
//

import Foundation
import Testing
@testable import ScotiaAssessment

@MainActor
struct TransactionDetailsViewModelTest {

    @Test
    func titleWhenTransactionIsCreditReturnsCreditTitle() {
        let viewModel = TransactionDetailsViewModel(
            transaction: MockTransactions.mockCredit
        )

        #expect(viewModel.title == "Credit transaction")
    }

    @Test
    func titleWhenTransactionIsDebitReturnsDebitTitle() {
        let viewModel = TransactionDetailsViewModel(transaction: MockTransactions.mockDebit)

        #expect(viewModel.title == "Debit transaction")
    }

    @Test
    func transactionDetailsReturnsFormattedValues() {
        let viewModel = TransactionDetailsViewModel(transaction: MockTransactions.mockDebit)

        #expect(viewModel.transactionFrom == "Momentum Regular Visa")
        #expect(viewModel.lastFourDigitsFormatted == "(8012)")
        #expect(viewModel.amountText == "$200.20")
    }

    @Test
    func titleWhenTransactionIsDebitReturnsDebitTransactionType() {
        let viewModel = TransactionDetailsViewModel(transaction: MockTransactions.mockDebit)

        #expect(viewModel.transactionType == TransactionType.debit)
    }

    @Test
    func titleWhenTransactionIsCreaditReturnsCreditTransactionType() {
        let viewModel = TransactionDetailsViewModel(transaction: MockTransactions.mockCredit)

        #expect(viewModel.transactionType == TransactionType.credit)
    }
}
