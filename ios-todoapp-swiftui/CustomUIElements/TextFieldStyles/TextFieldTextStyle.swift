//
//  TextFieldTextStyle.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

public struct TextFieldTextStyle: ViewModifier {

    public init () {}

    public func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .regular))
            .foregroundColor(.textFieldText)
    }
}
