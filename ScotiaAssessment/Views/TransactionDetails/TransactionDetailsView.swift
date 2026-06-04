//
//  TransactionDetailsView.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import SwiftUI

struct TransactionDetailsView: View {

    @Environment(Router.self) private var router: Router // Inject the global router

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TransactionDetailsView()
        .environment(Router())
}
