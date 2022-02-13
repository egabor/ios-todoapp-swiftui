//
//  CreateTodoItemScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Combine
import TodoAppNetwork

protocol TodoItemScreenViewModelProtocol: ObservableObject {

    var showsDismissButton: Bool { get }
    var showsDeleteButton: Bool { get }
    var title: String { get }

    var todoItemTitle: String { get set }
    var todoItemDescription: String { get set }
    var isCompleted: Bool { get set }
    var isLoading: Bool { get set }
    var isButtonLoading: Bool { get set }
    var saveButtonTitle: String { get }

    func save()
    func delete()
}

extension TodoItemScreenViewModelProtocol {
    var titleTextFieldPlaceholder: String {
        "Todo Title"
    }

    var deleteButtonTitle: String {
        "Delete"
    }
}

class CreateTodoItemScreenViewModel: TodoItemScreenViewModelProtocol {
    var showsDismissButton: Bool { true }
    var showsDeleteButton: Bool { false }
    var title: String { "Create new" }

    @Published var todoItemTitle: String = ""
    @Published var todoItemDescription: String = ""
    @Published var isCompleted: Bool = false
    @Published var isLoading: Bool = false
    @Published var isButtonLoading: Bool = false

    var saveButtonTitle: String { "Create" }

    @Injected private var todoApi: TodoApiProtocol

    func save() {
        isButtonLoading = true
        Task.init {
            do {
                _ = try await todoApi.createNew(
                    todoItem: .init(
                        id: nil,
                        title: todoItemTitle,
                        desc: todoItemDescription,
                        isCompleted: isCompleted,
                        createdAt: nil,
                        modifiedAt: nil)
                )
                // TODO: dismiss screen & refresh list
            } catch {
                print("error")
            }
            setLoadingOnMain(to: false)
        }
    }

    func delete() { /* Nothing to do here. */ }

    func setLoadingOnMain(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isButtonLoading = value
            self?.isLoading = value
        }
    }
}
