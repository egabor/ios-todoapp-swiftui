//
//  TextFieldState.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation

public protocol TextFieldStateProtocol: Equatable {
    var colorSet: ColorSet { get }
    var errorMessage: String? { get }
    var isEnabled: Bool { get }
    var isFocused: Bool { get }
    mutating func updateFocusState(isFocused: Bool)
}

public enum TextFieldState: TextFieldStateProtocol {
    case disabled, error(String, Bool), normal(Bool)

    public var colorSet: ColorSet {
        switch self {
        case .disabled: return .disabled
        case .error: return .error
        case .normal(let focused): return focused ? .editing : .normal
        }
    }

    public var errorMessage: String? {
        switch self {
        case .error(let error, _): return error
        default: return nil
        }
    }

    public var isEnabled: Bool {
        switch self {
        case .disabled: return false
        default: return true
        }
    }

    public var isFocused: Bool {
        switch self {
        case .normal(let focused): return focused
        case .error(_, let focused): return focused
        default: return false
        }
    }

    public mutating func updateFocusState(isFocused: Bool) {
        switch self {
        case .error(let message, _): self = .error(message, isFocused)
        case .normal: self = .normal(isFocused)
        default: break
        }
    }
}
