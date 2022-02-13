//
//  DependencyProvider.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Swinject
import todoapp_network

class DependencyProvider {

    static let shared = DependencyProvider()

    private let container = Container()
    private let config = Config()
    let assembler: Assembler

    private init() {
        assembler = Assembler(
            [
                todoapp_network.NetworkAssembly(
                    logLevel: .trace,
                    baseUrl: config.baseUrl,
                    apiKey: config.apiKey
                )
            ],
            container: container
        )
    }
}
