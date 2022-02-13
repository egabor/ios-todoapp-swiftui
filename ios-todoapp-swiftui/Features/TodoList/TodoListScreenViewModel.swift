//
//  TodoListScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 12..
//

import Foundation
import Combine

class TodoListScreenViewModel: ObservableObject {
    @Published var todoItems: [TodoItem] = []

    var hideCompletedItems: Bool = false

    init() {
       updateTodoItems()
    }

    func showOrHideCompletedItems() {
        hideCompletedItems.toggle()
        updateTodoItems()
    }

    func updateTodoItems() {
        if hideCompletedItems {
            todoItems = TodoItem.mockItems().filter { $0.isCompleted != true }
        } else {
            todoItems = TodoItem.mockItems()
        }
    }
}

// MARK: - Localized Strings

extension TodoListScreenViewModel {
    var title: String {
        "Todo Items"
    }

    var showOrHideCompletedButtonTitle: String {
        hideCompletedItems ? "Show All Items" : "Hide Completed Items"
    }
}
