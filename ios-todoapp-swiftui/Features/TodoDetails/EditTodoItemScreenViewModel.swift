//
//  EditTodoItemScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Combine
import TodoAppNetwork

class EditTodoItemScreenViewModel: TodoDetailsScreenViewModelProtocol {
    var showsDismissButton: Bool { false }
    var showsDeleteButton: Bool { true }
    
    var title: String { R.string.todoDetailsScreen.editTitle() }
    var saveButtonTitle: String { R.string.todoDetailsScreen.editButtonSave() }

    @Published var todoItemTitle: String = ""
    @Published var todoItemDescription: String = ""
    @Published var isCompleted: Bool = false
    @Published var isLoading: Bool = false
    @Published var isButtonLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var dismiss: PassthroughSubject<Void, Never> = .init()

    var reloadCallback: () -> Void

    @Injected private var todoApi: TodoApiProtocol

    let todoItem: TodoItem

    init(todoItem: TodoItem, reloadCallback: @escaping () -> Void) {
        self.todoItem = todoItem
        self.reloadCallback = reloadCallback
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
                DispatchQueue.main.async {
                    self.reloadCallback()
                    self.dismiss.send()
                }
            } catch let error as TodoAppNetwork.Common.ErrorMessage.Response {
                showNetworkErrorOnMain(error: error)
            } catch {
                showErrorOnMain(message: R.string.localizable.alertMessageGeneral())
            }
            setButtonLoadingOnMain(to: false)
        }
    }

    func delete() {
        isLoading = true
        Task.init {
            do {
                _ = try await todoApi.deleteTodoItem(for: todoItem.id)
                reloadOnMain()
                dismissOnMain()
            } catch let error as TodoAppNetwork.Common.ErrorMessage.Response {
                showNetworkErrorOnMain(error: error)
            } catch {
                showErrorOnMain(message: R.string.localizable.alertMessageGeneral())
            }
            setLoadingOnMain(to: false)
        }
    }
}
