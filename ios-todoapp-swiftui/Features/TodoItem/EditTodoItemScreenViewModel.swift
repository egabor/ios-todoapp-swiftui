//
//  EditTodoItemScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import TodoAppNetwork

class EditTodoItemScreenViewModel: TodoItemScreenViewModelProtocol {
    var showsDismissButton: Bool { false }
    var showsDeleteButton: Bool { true }
    var title: String { "Edit Todo" }
    
    @Published var todoItemTitle: String = ""
    @Published var todoItemDescription: String = ""
    @Published var isCompleted: Bool = false
    @Published var isLoading: Bool = false
    @Published var isButtonLoading: Bool = false

    var saveButtonTitle: String { "Save" }

    @Injected private var todoApi: TodoApiProtocol

    let todoItem: TodoItem

    init(todoItem: TodoItem) {
        self.todoItem = todoItem
        populate()
    }

    func populate() {
        todoItemTitle = todoItem.title
        todoItemDescription = todoItem.desc ?? ""
        isCompleted = todoItem.isCompleted
    }

    func save() {
        isButtonLoading = true
        Task.init {
            do {
                _ = try await todoApi.update(
                    todoItem: .init(
                        id: todoItem.id,
                        title: todoItemTitle,
                        desc: todoItemDescription,
                        isCompleted: isCompleted,
                        createdAt: todoItem.createdAt,
                        modifiedAt: todoItem.modifiedAt),
                    for: todoItem.id
                )
                // TODO: dismiss screen & refresh list
            } catch {
                print("error")
            }
            setLoadingOnMain(to: false)
        }
    }

    func delete() {
        isLoading = true
        Task.init {
            do {
                _ = try await todoApi.deleteTodoItem(for: todoItem.id) // TODO: check status code why 405
            } catch {
                print("error")
            }
            setLoadingOnMain(to: false)
        }
    }

    func setLoadingOnMain(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isButtonLoading = value
            self?.isLoading = value
        }
    }
}
