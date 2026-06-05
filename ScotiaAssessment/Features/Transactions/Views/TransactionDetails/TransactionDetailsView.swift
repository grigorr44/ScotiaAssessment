//
//  TransactionDetailsView.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import SwiftUI

struct TransactionDetailsView: View {

    @Environment(Router.self) private var router

    // MARK: - Properties

    private let viewModel: TransactionDetailsViewModel

    // MARK: - Initialiser

    init(viewModel: TransactionDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            VStack(spacing: AppSpacing.xxxLarge) {
                header
                detailsSection
                Spacer()
                closeButton
            }
            .padding(AppSpacing.xLarge)
            .background(Color.white)
            .cornerRadius(AppCornerRadius.large)
            .shadow(radius: 1)

            Spacer()
        }
        .padding(AppSpacing.medium)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Transaction Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    private var header: some View {
        VStack(spacing: AppSpacing.large) {
            Image(.successIcon)
                .renderingMode(.template)
                .foregroundStyle(statusColor)

            Text(viewModel.title)
                .font(.title2)
        }
    }

    private var detailsSection: some View {
        VStack(spacing: AppSpacing.large) {
            TransactionDetailsItemView(
                title: "From",
                value: transactionFromAttributedText,
            )
            Divider()
            TransactionDetailsItemView(
                title: "Amount",
                value: AttributedString(viewModel.amountText),
            )
        }
    }

    private var closeButton: some View {
        Button {
            router.pop()
        } label: {
            Text("Close")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.red)
                .cornerRadius(AppCornerRadius.medium)
        }
    }

    private var statusColor: Color {
        switch viewModel.transactionType {
        case .credit:
            return .green
        case .debit:
            return .red
        }
    }

    private var transactionFromAttributedText: AttributedString {
        var message1: AttributedString {
            var result = AttributedString(viewModel.transactionFrom)
            result.font = .subheadline
            result.foregroundColor = .primary
            return result
        }

        var message2: AttributedString {
            var result = AttributedString(" \(viewModel.lastFourDigitsFormatted)")
            result.font = .subheadline
            result.foregroundColor = .secondary
            return result
        }

        return message1 + message2
    }
}

#Preview("Debit") {
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

    NavigationStack {
        TransactionDetailsView(
            viewModel: TransactionDetailsViewModel(transaction: mockDebit)
        )
        .environment(Router())
    }
}

#Preview("Credit") {
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

    NavigationStack {
        TransactionDetailsView(
            viewModel: TransactionDetailsViewModel(transaction: mockCredit)
        )
        .environment(Router())
    }
}
