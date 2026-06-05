//
//  MockTransactions.swift
//  ScotiaAssessmentTests
//
//  Created by Grigor Grigoryan on 2026-06-05.
//

import Foundation
@testable import ScotiaAssessment

enum MockTransactions {

    static let mockDebit = Transaction(
        id: "123=",
        type: .debit,
        merchantName: "Mb - Cash Advance To - 1785",
        description: "Bill payment",
        amount: 200.20,
        currency: "CAD",
        postedDate: "2021-05-31",
        fromAccount: "Momentum Regular Visa",
        fromCardNumber: "4537350001688012"
    )

    static let mockCredit = Transaction(
        id: "456=",
        type: .credit,
        merchantName: "Payment-thank You Scotiabank Transit 40592 Markham On",
        description: "Payment (Scotiabank)",
        amount: 5.00,
        currency: "CAD",
        postedDate: "2021-03-30",
        fromAccount: "Momentum Regular Visa",
        fromCardNumber: "4537350001688004"
    )
}
