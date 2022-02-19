//
//  CreateTodoItemScreenViewModel.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Combine
import TodoAppNetwork

class CreateTodoItemScreenViewModel: TodoDetailsScreenViewModelProtocol {
    var showsDismissButton: Bool { true }
    var showsDeleteButton: Bool { false }
    
    var title: String { R.string.todoDetailsScreen.createTitle() }
    var saveButtonTitle: String {  R.string.todoDetailsScreen.createButtonCreate() }

    @Published var todoItemTitle: String = ""
    @Published var todoItemDescription: String = ""
    @Published var isCompleted: Bool = false

    // LoadingCapable
    @Published var isLoading: Bool = false

    // ButtonLoadingCapable
    @Published var isButtonLoading: Bool = false

    // ErrorCapable
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var dismiss: PassthroughSubject<Void, Never> = .init()

    var reloadCallback: () -> Void

    @Injected private var todoApi: TodoApiProtocol

    init(reloadCallback: @escaping () -> Void) {
        self.reloadCallback = reloadCallback
    }

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
                reloadOnMain()
                dismissOnMain()
            } catch let error as TodoAppNetwork.Common.ErrorMessage.Response {
                showNetworkErrorOnMain(error: error)
            } catch {
                showErrorOnMain(message: R.string.localizable.alertMessageGeneral())
            }
            setButtonLoadingOnMain(to: false)
        }
    }

    func delete() { /* Nothing to do here. */ }
}
