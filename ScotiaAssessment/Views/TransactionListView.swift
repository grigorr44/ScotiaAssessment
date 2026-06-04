//
//  TransactionListView.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-03.
//

import SwiftUI

struct TransactionListView: View {
    // MARK: - Properties

    private var viewModel: TransactionListViewModel

    // MARK: - Initialiser

    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Transacton")
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    await viewModel.fetchTransactions()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.loadingState {
        case .loading, .idle:
            ProgressView()
        case .error(let error):
            errorView(error.localizedCapitalized)
        case .success:
            List(viewModel.transactions) { transaction in
                NavigationLink(value: transaction) {
                    TransactionItemView(transaction: transaction)
                }
            }
        }
    }

    private func errorView(_ errorMessage: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.white, .red)
            Text(errorMessage)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    TransactionListView(
        viewModel: TransactionListViewModel(
            transactionService: TransactionServiceImpl()
        )
    )
}
