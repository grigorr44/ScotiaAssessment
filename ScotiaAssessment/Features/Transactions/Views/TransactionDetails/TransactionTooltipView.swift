//
//  TransactionTooltipView.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import SwiftUI

struct TransactionTooltipView: View {
    // MARK: - Properties

    @State private var isExpanded = false

    // MARK: - Body

    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.medium) {
            Image(.buddyTipIcon)
                .font(.title2)
                .foregroundStyle(.secondary)

            VStack(spacing: AppSpacing.xLarge) {
                Text(titleAttributedText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let detailsAttributedText {
                    Text(detailsAttributedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity)
                }
            }
            .animation(.spring(duration: 0.25), value: isExpanded)
        }
        .padding(AppSpacing.xLarge)
        .background(Color.white)
        .overlay {
            RoundedRectangle(cornerRadius: AppCornerRadius.small)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 8)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(duration: 0.25)) {
                isExpanded.toggle()
            }
        }
    }

    // MARK: - Private Properties

    private var titleAttributedText: AttributedString {
        let title = makeText(Constants.title, color: .primary)
        let button = makeText(Constants.showMoreLink, color: .blue, isBold: true)

        return isExpanded ? title : title + " " + button
    }

    private var detailsAttributedText: AttributedString? {
        guard isExpanded else { return nil }

        let details = makeText(Constants.details, color: .primary)
        let button = makeText(Constants.showLessLink, color: .blue, isBold: true)

        return details + " " + button
    }

    // MARK: - Private Methods

    private func makeText(
        _ value: String,
        color: Color,
        isBold: Bool = false
    ) -> AttributedString {
        var result = AttributedString(value)
        result.font = isBold ? .subheadline.pointSize(14).bold() : .subheadline.pointSize(14)
        result.foregroundColor = color
        return result
    }
}

// MARK: - Constants

private extension TransactionTooltipView {
    enum Constants {
        static let title = "Transactions are processed Monday to Friday (excluding holidays)."
        static let details = "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day."

        static let showMoreLink = "Show more"
        static let showLessLink = "Show less"
    }
}

#Preview("Collapsed") {
    VStack {
        TransactionTooltipView()
            .padding(AppSpacing.medium)
            .padding(AppSpacing.xLarge)
        Spacer()
    }
}
