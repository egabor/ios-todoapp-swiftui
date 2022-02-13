//
//  TextFieldStyle.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

public struct TextFieldStyle: ViewModifier {
    let state: TextFieldState

    public init(state: TextFieldState) {
        self.state = state
    }

    public func body(content: Content) -> some View {
        content
            .padding(16)
            .background(state.colorSet.background)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 1)
                    .foregroundColor(state.colorSet.border)
            )
            .accentColor(state.colorSet.caret)
            .disabled(state == .disabled)
            .modifier(TextFieldTextStyle())
    }
}
