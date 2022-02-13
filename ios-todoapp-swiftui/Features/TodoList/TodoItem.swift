//
//  TodoItem.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 12..
//

import Foundation

struct TodoItem: Decodable, Identifiable {
    var id: String
    var title: String
    var description: String?
    var isCompleted: Bool
    var createdAt: Date?
    var modifiedAt: Date?
}

// MOCK Data

extension TodoItem {
    static func mockItems() -> [Self] {
        [
            .init(
                id: "0001",
                title: "First mock item",
                description: "Short description",
                isCompleted: false,
                createdAt: Date(),
                modifiedAt: Date()
            ),
            .init(
                id: "0002",
                title: "Second mock item",
                description: "Short description",
                isCompleted: true,
                createdAt: Date(),
                modifiedAt: Date()
            ),
            .init(
                id: "0003",
                title: "Third mock item",
                description: "Short description",
                isCompleted: false,
                createdAt: Date(),
                modifiedAt: Date()
            )
        ]
    }

    static func previewObject() -> Self {
            .init(
                id: "0001",
                title: "First mock item",
                description: "Short description",
                isCompleted: false,
                createdAt: Date(),
                modifiedAt: Date()
            )
    }
}
