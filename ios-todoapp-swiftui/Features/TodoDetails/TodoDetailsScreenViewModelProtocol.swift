//
//  TodoDetailsScreenViewModelProtocol.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 19..
//

import Foundation
import Combine

protocol TodoDetailsScreenViewModelProtocol: ObservableObject, ErrorCapable, LoadingCapable, ButtonLoadingCapable {

    var showsDismissButton: Bool { get }
    var showsDeleteButton: Bool { get }

    var title: String { get }
    var saveButtonTitle: String { get }

    var todoItemTitle: String { get set }
    var todoItemDescription: String { get set }
    var isCompleted: Bool { get set }
    var dismiss: PassthroughSubject<Void, Never> { get }

    var showError: Bool { get set }
    var errorMessage: String { get set }

    var reloadCallback: () -> Void { get set }

    func save()
    func delete()
}

extension TodoDetailsScreenViewModelProtocol {

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

extension TodoDetailsScreenViewModelProtocol {
    var titleTextFieldPlaceholder: String {
        R.string.todoDetailsScreen.inputTitlePlaceholder()
    }

    var completedToggleTitle: String {
        R.string.todoDetailsScreen.toggleCompletedTitle()
    }

    var deleteButtonTitle: String {
        R.string.todoDetailsScreen.editButtonDelete()
    }
}
