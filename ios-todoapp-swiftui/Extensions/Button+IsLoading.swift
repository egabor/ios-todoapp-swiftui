//
//  Button+IsLoading.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

private struct ButtonIsLoadingKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[ButtonIsLoadingKey.self] }
        set { self[ButtonIsLoadingKey.self] = newValue }
    }
}

public extension View {
    func isLoading(_ isLoading: Bool) -> some View {
        environment(\.isLoading, isLoading)
            .disabled(isLoading)
    }
}
