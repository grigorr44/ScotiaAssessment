//
//  TransactionDetailItemView.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import SwiftUI

struct TransactionDetailsItemView: View {
    // MARK: - Properties
    
    let title: String
    let value: AttributedString

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TransactionDetailsItemView(
        title: "From",
        value: "Momentum Regular Visa (8012)"
    )
}
