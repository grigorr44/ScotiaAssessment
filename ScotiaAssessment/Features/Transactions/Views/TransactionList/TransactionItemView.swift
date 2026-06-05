//
//  TransactionItemView.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import SwiftUI

struct TransactionItemView: View {
    // MARK: - Properties

    private let transaction: Transaction

    // MARK: - Initialiser

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: AppSpacing.medium) {
                Text(transaction.merchantName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .truncationMode(.tail) // Depending on the business requirements.

                Text(transaction.amount.formatted(.currency(code: transaction.currency)))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                    .lineLimit(1)
                    .layoutPriority(1)
            }

            if let description = transaction.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
        }
    }
}

#Preview {
    let mockDebit = Transaction(
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

    TransactionItemView(
        transaction: mockDebit
    )
}

#Preview {
    let mockCredit = Transaction(
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

    TransactionItemView(
        transaction: mockCredit
    )
}
