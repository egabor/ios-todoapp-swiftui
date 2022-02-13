//
//  Config.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Logging

enum ConfigKey: String {
    case bundleId = "BUNDLE_ID"
    case baseUrl = "BASE_URL"
    case apiKey = "API_KEY"
}

class Config {
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            return [:]
        }
        return dict
    }()

    // MARK: - Plist values
    var bundleId: String {
        value(for: .bundleId)
    }

    var baseUrl: String {
        value(for: .baseUrl)
    }

    var apiKey: String {
        value(for: .apiKey)
    }

    private lazy var logger: Logger = { .init(label: bundleId) }()

    init() {
        logger.debug("\(Self.self) Initialized [\(bundleId)]")
    }

    private func value(for key: ConfigKey) -> String {
        guard let value = Config.infoDictionary[key.rawValue] as? String else {
            logger.critical("💥 [\(key.rawValue)] is not set in plist file.")
            return ""
        }
        return value
    }

    deinit {
        logger.debug("\(Self.self) Deinitialized")
    }
}
