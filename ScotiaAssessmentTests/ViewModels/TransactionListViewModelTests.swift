//
//  TransactionListViewModelTests.swift
//  ScotiaAssessmentTests
//
//  Created by Grigor Grigoryan on 2026-06-05.
//

import Foundation
import Testing
@testable import ScotiaAssessment

@MainActor
struct TransactionListViewModelTests {

    @Test
    func fetchTransactionsWhenServiceSucceeds() async {
        let expectedTransactions = [MockTransactions.mockDebit]
        let service = MockTransactionService(result: .success(expectedTransactions))
        let viewModel = TransactionListViewModel(transactionService: service)

        await viewModel.fetchTransactions()

        #expect(viewModel.transactions == expectedTransactions)

        if case .success = viewModel.loadingState {
            #expect(true)
        } else {
            Issue.record("Expected success state")
        }
    }

    @Test
    func fetchTransactionsWhenServiceFails() async {
        let service = MockTransactionService(result: .failure(MockError.failed))
        let viewModel = TransactionListViewModel(transactionService: service)

        await viewModel.fetchTransactions()

        #expect(viewModel.transactions.isEmpty)

        if case .error(let message) = viewModel.loadingState {
            #expect(!message.isEmpty)
        } else {
            Issue.record("Expected error state")
        }
    }
}

private final class MockTransactionService: TransactionService {
    private let result: Result<[Transaction], Error>

    init(result: Result<[Transaction], Error>) {
        self.result = result
    }

    func fetchTransactions() async throws -> [Transaction] {
        try result.get()
    }
}

private enum MockError: Error {
    case failed
}
