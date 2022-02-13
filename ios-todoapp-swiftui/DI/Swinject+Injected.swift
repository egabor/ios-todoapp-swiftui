//
//  Swinject+Injected.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Swinject

@propertyWrapper
struct Injected<T> {
    private let resolver = (DependencyProvider.shared.assembler.resolver as! Container).synchronize() // swiftlint:disable:this force_cast

    init() {}

    lazy var wrappedValue: T = {
        return resolver.resolve(T.self)!
    }()
}
