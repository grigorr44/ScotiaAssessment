//
//  TransactionListViewModel.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation
import Observation

@MainActor
@Observable
final class TransactionListViewModel {

    // MARK: Properties

    private(set) var transactions: [Transaction] = []
    private(set) var loadingState: TransactionListState = .idle
    private let transactionService: TransactionService

    // MARK: Initialization

    init(transactionService: TransactionService) {
        self.transactionService = transactionService
    }

    // MARK: Functions

    func fetchTransactions() async {
        loadingState = .loading
        do {
            transactions = try await transactionService.fetchTransactions()
            loadingState = .success
        } catch {
            loadingState = .error(error.localizedDescription)
        }
    }
}

/// Represents the loading state of the transaction list screen.
enum TransactionListState {
    case idle
    case loading
    case success
    case error(String)
}
