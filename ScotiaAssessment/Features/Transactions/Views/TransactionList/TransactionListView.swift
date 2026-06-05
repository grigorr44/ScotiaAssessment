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

    @State private var router = Router()

    // MARK: - Initialiser

    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationTitle("Transactons")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationDestination(for: AppRoute.self) { rout in
                    switch rout {
                    case .transactionDetail(let transaction):
                        TransactionDetailsView(viewModel: .init(transaction: transaction))
                    }
                }
                .task {
                    // Load transactions when the list screen appears.
                    // Refresh behavior can be adjusted later based on business needs.
                    await viewModel.fetchTransactions()
                }
        }
        .environment(router)
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
                NavigationLink(value: AppRoute.transactionDetail(transaction)) {
                    TransactionItemView(transaction: transaction)
                }
            }
        }
    }

    private func errorView(_ errorMessage: String) -> some View {
        VStack(spacing: AppSpacing.small) {
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
