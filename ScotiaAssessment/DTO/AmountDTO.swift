//
//  AmountDTO.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import Foundation

struct AmountDTO: Decodable {
    let value: Decimal
    let currency: String
}
