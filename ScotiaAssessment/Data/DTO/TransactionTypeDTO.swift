//
//  TransactionTypeDTO.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

enum TransactionTypeDTO: String, Decodable {
    case credit = "CREDIT"
    case debit = "DEBIT"
}
