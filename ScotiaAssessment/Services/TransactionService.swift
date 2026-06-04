//
//  TransactionService.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

protocol TransactionService {
    func fetchTransactions() async throws -> [Transaction]
}

final class TransactionServiceImpl: TransactionService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }

    func fetchTransactions() async throws -> [Transaction] {
        let response: TransactionsResponseDTO = try await networkClient.performRequest()
        return response.transactions.map { $0.toDomain() }
    }
}

