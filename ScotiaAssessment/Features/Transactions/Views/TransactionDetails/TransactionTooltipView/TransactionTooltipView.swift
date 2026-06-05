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
                Text(tooltipTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if isExpanded {
                    Text(tooltipDetails)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity.combined(with: .opacity))
                }
            }
            .font(.subheadline.pointSize(14))
            .foregroundStyle(.primary)
            .tint(.blue)
            .animation(.spring, value: isExpanded)
            .fixedSize(horizontal: false, vertical: true)
            .environment(\.openURL, OpenURLAction { url in
                handleURL(url)
            })
        }
        .padding(AppSpacing.xLarge)
        .background(Color.white)
        .overlay {
            RoundedRectangle(cornerRadius: AppCornerRadius.small)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.1), radius: 16, x: 8, y: 8)
    }

    // MARK: - Private Properties

    private var tooltipTitle: AttributedString {
        let markdown = isExpanded
            ? Constants.title
            : Constants.title + " " + Constants.showMoreLink

        return makeAttributedString(from: markdown)
    }

    private var tooltipDetails: AttributedString {
        makeAttributedString(from: Constants.details + " " + Constants.showLessLink)
    }

    // MARK: - Private Methods

    private func handleURL(_ url: URL) -> OpenURLAction.Result {
        guard url.absoluteString == Constants.toggleURL else {
            return .systemAction
        }

        withAnimation(.interactiveSpring(duration: 0.2)) {
            isExpanded.toggle()
        }

        return .handled
    }

    private func makeAttributedString(from markdown: String) -> AttributedString {
        (try? AttributedString(markdown: markdown)) ?? AttributedString(markdown)
    }
}

// MARK: - Constants

private extension TransactionTooltipView {
    enum Constants {
        static let toggleURL = "action://toggle-tooltip"

        static let title = "Transactions are processed Monday to Friday (excluding holidays)."
        static let details = "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day."

        static let showMoreLink = "[Show more](\(toggleURL))"
        static let showLessLink = "[Show less](\(toggleURL))"
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
