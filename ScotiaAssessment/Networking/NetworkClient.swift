//
//  NetworkClient.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

protocol NetworkClient {
    func performRequest<T: Decodable>() async throws -> T
}

final class NetworkClientImpl: NetworkClient {

    /// The assessment asks us not to call a real API.
    /// For now, we mock the network response by reading the bundled transaction-list JSON file.
    func performRequest<T: Decodable>() async throws -> T {
        guard let url = Bundle.main.url(
            forResource: "transaction-list",
            withExtension: "json"
        ) else {
            throw NetworkError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
