//
//  LoadingViewModifier.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

public struct LoadingViewModifier: ViewModifier {

    private let fadeTransition: AnyTransition = .opacity.animation(.easeInOut)

    private var isLoading: Bool

    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    public func body(content: Content) -> some View {
            content
                .overlay(loadingView)
    }

    @ViewBuilder
    public var loadingView: some View {
        if isLoading {
            ZStack {
                Color.black
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                loadingIndicator
            }
            .transition(fadeTransition)
        }
    }

    public var loadingIndicator: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: .white)
            )
            .scaleEffect(1.7, anchor: .center)
    }
}

public extension View {
    func contentLoading(_ isLoading: Bool) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}

