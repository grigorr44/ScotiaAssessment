//
//  Router.swift
//  ScotiaAssessment
//
//  Created by Grigor Grigoryan on 2026-06-04.
//

import Foundation
import Observation

@MainActor
@Observable
final class Router {
    // MARK: Properties

    var path: [AppRoute] = []

    // MARK: Functions

    func navigate(to rout: AppRoute) {
        path.append(rout)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}

