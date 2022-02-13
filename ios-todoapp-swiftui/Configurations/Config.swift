//
//  Config.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Logging

enum ConfigKey: String {
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

    var baseUrl: String {
        value(for: .baseUrl)
    }

    var apiKey: String {
        value(for: .apiKey)
    }

    private func value(for key: ConfigKey) -> String {
        guard let value = Config.infoDictionary[key.rawValue] as? String else {
            print("💥 [\(key.rawValue)] is not set in plist file.")
            return ""
        }
        return value
    }
}
