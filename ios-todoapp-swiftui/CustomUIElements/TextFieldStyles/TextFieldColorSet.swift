//
//  TextFieldColorSet.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

public struct ColorSet {
    public let background: Color
    public let border: Color
    public let caret: Color

    fileprivate init(
        background: Color,
        border: Color,
        caret: Color = .clear
    ) {
        self.background = background
        self.border = border
        self.caret = caret
    }

    public static var normal: ColorSet {
        .init(
            background: .generalTextFieldNormalBackground,
            border: .generalTextFieldNormalBorder
        )
    }

    public static var editing: ColorSet {
        .init(
            background: .generalTextFieldEditingBackground,
            border: .generalTextFieldEditingBorder,
            caret: .generalTextFieldEditingCaret
        )
    }

    public static var disabled: ColorSet {
        .init(
            background: .generalTextFieldDisabledBackground,
            border: .generalTextFieldDisabledBorder
        )
    }

    public static var error: ColorSet {
        .init(
            background: .generalTextFieldErrorBackground,
            border: .generalTextFieldErrorBorder,
            caret: .generalTextFieldErrorCaret
        )
    }
}
