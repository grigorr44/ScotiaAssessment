//
//  TransactionServiceTest.swift
//  ScotiaAssessmentTests
//
//  Created by Grigor Grigoryan on 2026-06-05.
//

import Foundation
import Testing
@testable import ScotiaAssessment

struct TransactionServiceTests {

    @Test
    func fetchTransactionsWhenNetworkClientSucceeds() async throws {
        let response = TransactionsResponseDTO(
            transactions: [
                TransactionDTO(
                    key: "123=",
                    transactionType: .debit,
                    merchantName: "Mb - Cash Advance To - 1785",
                    description: "Bill payment",
                    amount: AmountDTO(value: 200.20, currency: "CAD"),
                    postedDate: "2021-05-31",
                    fromAccount: "Momentum Regular Visa",
                    fromCardNumber: "4537350001688012"
                )
            ]
        )

        let networkClient = MockNetworkClient(result: .success(response))
        let service = await TransactionServiceImpl(networkClient: networkClient)
        let transactions = try await service.fetchTransactions()

        #expect(transactions == [MockTransactions.mockDebit])
    }

    @Test
    func fetchTransactionsWhenNetworkClientFailsThrowsError() async {
        let networkClient = MockNetworkClient(result: .failure(MockTransactionServiceError.failed))
        let service = await TransactionServiceImpl(networkClient: networkClient)

        do {
            _ = try await service.fetchTransactions()
            Issue.record("Expected fetchTransactions to throw")
        } catch {
            #expect(error is MockTransactionServiceError)
        }
    }
}

private final class MockNetworkClient: NetworkClient {
    private let result: Result<TransactionsResponseDTO, Error>

    init(result: Result<TransactionsResponseDTO, Error>) {
        self.result = result
    }

    func performRequest<T: Decodable>() async throws -> T {
        let response = try result.get()
        guard let typedResponse = response as? T else {
            throw MockNetworkClientError.invalidResponseType
        }

        return typedResponse
    }

}

private enum MockNetworkClientError: Error {
    case invalidResponseType
}

private enum MockTransactionServiceError: Error {
    case failed
}
