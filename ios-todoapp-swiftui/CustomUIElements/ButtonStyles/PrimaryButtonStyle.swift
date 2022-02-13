//
//  ios_todoapp_swiftuiApp.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    enum ButtonState {
        case normal
        case highlighted
        case disabled
        case loading
    }

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.isLoading) private var isLoading

    struct Config {
        static let width: CGFloat = .infinity
        static let height: CGFloat = 50
        static let cornerRadius: CGFloat = 6
        static let font: Font = .system(size: 18, weight: .semibold)

        static let highlightedScaleEffect: CGFloat = 0.98
        static let normalScaleEffect: CGFloat = 1
    }

    var animation: Animation {
        return .easeInOut(duration: 0.2)
    }

    public init() {}

    // MARK: Content Composing Methods

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        HStack {
            view(for: configuration)
        }
        .padding(1)
        .frame(maxWidth: Config.width)
        .frame(height: Config.height)
        .background(backgroundColor(for: state(isPressed)))
        .foregroundColor(foregroundColor(for: state(isPressed)))
        .clipShape(RoundedRectangle(cornerRadius: Config.cornerRadius))
        .scaleEffect(scaleEffectValue(for: state(isPressed)))
        .animation(animation, value: isPressed)
    }

    @ViewBuilder
    func view(for configuration: Configuration) -> some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        } else {
            configuration.label
                .font(Config.font)
        }
    }

    // MARK: - State Helper

    func state(_ isPressed: Bool? = nil) -> ButtonState {
        guard !isLoading else { return .loading }
        guard isEnabled else { return .disabled }
        guard let isPressed = isPressed, isPressed else { return .normal }
        return .highlighted
    }

    // MARK: - State Based Properties

    func backgroundColor(for state: ButtonState) -> Color {
        switch state {
        case .disabled, .loading: return Color.primaryButtonDisabledBackground
        case .highlighted: return Color.primaryButtonHighlightedBackground
        default: return Color.primaryButtonNormalBackground
        }
    }

    func foregroundColor(for state: ButtonState) -> Color {
        switch state {
        case .disabled, .loading: return Color.primaryButtonDisabledTitle
        case .highlighted: return Color.primaryButtonHighlightedTitle
        default: return Color.primaryButtonNormalTitle
        }
    }

    func scaleEffectValue(for state: ButtonState) -> CGFloat {
        switch state {
        case .highlighted: return Config.highlightedScaleEffect
        default: return Config.normalScaleEffect
        }
    }
}
