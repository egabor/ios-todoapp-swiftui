//
//  TodoListScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 12..
//

import Foundation
import Combine
import TodoAppNetwork

class TodoListScreenViewModel: ObservableObject, ErrorCapable {
    @Published var isLoading: Bool = false
    @Published var todoItems: [TodoItem] = []
    @Published var isPresentingTodoDetails: Bool = false

    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private var todoItemCache: [TodoItem] = []

    var hideCompletedItems: Bool = false

    @Injected private var todoApi: TodoApiProtocol

    init() {
        loadTodoList()
    }

    func loadTodoList() {
        isLoading = true
        Task.init {
            do {
                let result = try await todoApi.getTodoList()
                DispatchQueue.main.async { [weak self] in
                    self?.todoItemCache = result
                    self?.processTodoItems()
                }
            } catch let error as TodoAppNetwork.Common.ErrorMessage.Response {
                showNetworkErrorOnMain(error: error)
            } catch {
                showErrorOnMain(message: "Something went wrong")
            }
            setLoadingOnMain(to: false)
        }
    }

    func showOrHideCompletedItems() {
        hideCompletedItems.toggle()
        processTodoItems()
    }

    func processTodoItems() {
        if hideCompletedItems {
            todoItems = todoItemCache.filter { $0.isCompleted != true }
        } else {
            todoItems = todoItemCache
        }
    }

    func setLoadingOnMain(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = value
        }
    }

    func createTodoItem() {
        isPresentingTodoDetails = true
    }

    func createTodoItemViewModel() -> CreateTodoItemScreenViewModel {
        .init(reloadCallback: loadTodoList)
    }

    func editTodoItemViewModel(todoItem: TodoItem) -> EditTodoItemScreenViewModel {
        .init(todoItem: todoItem, reloadCallback: loadTodoList)
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
