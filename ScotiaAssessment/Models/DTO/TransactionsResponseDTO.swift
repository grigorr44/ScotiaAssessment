//
//  TransactionsResponseDTO.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

struct TransactionsResponseDTO: Decodable {
    let transactions: [TransactionDTO]
}
