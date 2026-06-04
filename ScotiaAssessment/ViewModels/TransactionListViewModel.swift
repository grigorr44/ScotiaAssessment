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
    private(set) var state: TransactionListState = .idle
    private let transactionService: TransactionService

    // MARK: Initialization

    init(transactionService: TransactionService) {
        self.transactionService = transactionService
    }

    // MARK: Functions

    func fetchTransactions() async {
        state = .loading
        do {
            transactions = try await transactionService.fetchTransactions()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}


enum TransactionListState {
    case idle      // The view has just appeared and no action has been taken yet
    case loading   // The API call is actively running
    case success   // Data loaded successfully
    case error(String)   // An error occurred
}
