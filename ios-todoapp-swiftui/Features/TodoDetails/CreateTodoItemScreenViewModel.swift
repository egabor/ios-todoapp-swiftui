//
//  CreateTodoItemScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Combine
import TodoAppNetwork

protocol LoadingCapable: AnyObject {
    var isLoading: Bool { get set }
}

extension LoadingCapable {
    func setLoadingOnMain(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = value
        }
    }
}

protocol ErrorCapable: AnyObject {
    var showError: Bool { get set }
    var errorMessage: String { get set }
}

extension ErrorCapable {
    func showErrorOnMain(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = message
            self?.showError = true
        }
    }

    func showNetworkErrorOnMain(error: TodoAppNetwork.Common.ErrorMessage.Response) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = "Status code: \(error.statusCode ?? -1)"
            self?.showError = true
        }
    }

    var errorAlertTitle: String {
        "Error"
    }

    var errorAlertOkButtonTitle: String {
        "Ok"
    }
}

protocol TodoItemScreenViewModelProtocol: ObservableObject, ErrorCapable, LoadingCapable {

    var showsDismissButton: Bool { get }
    var showsDeleteButton: Bool { get }
    var title: String { get }

    var todoItemTitle: String { get set }
    var todoItemDescription: String { get set }
    var isCompleted: Bool { get set }
    var dismiss: PassthroughSubject<Void, Never> { get }

    var saveButtonTitle: String { get }

    var showError: Bool { get set }
    var errorMessage: String { get set }

    var reloadCallback: () -> Void { get set }

    func save()
    func delete()
}

extension TodoItemScreenViewModelProtocol {

    func reloadOnMain() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadCallback()
        }
    }

    func dismissOnMain() {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss.send()
        }
    }
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
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var dismiss: PassthroughSubject<Void, Never> = .init()

    var saveButtonTitle: String { "Create" }

    var reloadCallback: () -> Void

    @Injected private var todoApi: TodoApiProtocol

    init(reloadCallback: @escaping () -> Void) {
        self.reloadCallback = reloadCallback
    }

    func save() {
        isLoading = true
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
                reloadOnMain()
                dismissOnMain()
            } catch let error as TodoAppNetwork.Common.ErrorMessage.Response {
                showNetworkErrorOnMain(error: error)
            }
            setLoadingOnMain(to: false)
        }
    }

    func delete() { /* Nothing to do here. */ }
}
