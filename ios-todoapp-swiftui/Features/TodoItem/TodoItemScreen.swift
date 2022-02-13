//
//  TodoItemScreen.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

enum TodoItemFocusableField: Hashable {
    case title
    case description
}

struct TodoItemScreen<ViewModel: TodoItemScreenViewModelProtocol>: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focus: TodoItemFocusableField?

    // MARK: - LEVEL 0 Views: Body & Content Wrapper

    var body: some View {
        content
            .padding()
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: { ToolbarItem(placement: .navigationBarLeading, content: dismissButton) })
            .contentLoading(viewModel.isLoading)
            .disabled(viewModel.isLoading || viewModel.isButtonLoading)
    }

    var content: some View {
        VStack {
            todoTitleTextField
            todoDescriptionTextEditor
            isCompletedToggle
            Spacer()
            saveButton
            deleteButton
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    @ViewBuilder
    func dismissButton() -> some View {
        if viewModel.showsDismissButton {
            Button(
                action: { dismiss() },
                label: { Image(systemName: "xmark") }
            )
        }
    }

    var todoTitleTextField: some View {
        TextField(
            viewModel.titleTextFieldPlaceholder,
            text: $viewModel.todoItemTitle
        )
            .focused($focus, equals: TodoItemFocusableField.title)
            .modifier(TextFieldStyle(state: .normal(focus == .title)))
    }

    var todoDescriptionTextEditor: some View {
        TextEditor(text: $viewModel.todoItemDescription)
            .focused($focus, equals: TodoItemFocusableField.description)
            .modifier(TextFieldStyle(state: .normal(focus == .description)))
            .frame(height: 200)
    }

    var isCompletedToggle: some View {
        Toggle(
            isOn: $viewModel.isCompleted,
            label: { Text("Completed") }
        )
    }

    var saveButton: some View {
        Button(viewModel.saveButtonTitle, action: viewModel.save)
            .buttonStyle(PrimaryButtonStyle())
            .isLoading(viewModel.isButtonLoading)
    }

    @ViewBuilder
    var deleteButton: some View {
        if viewModel.showsDeleteButton {
            Button(viewModel.deleteButtonTitle, action: viewModel.delete)
                .buttonStyle(DestructiveButtonStyle())
        }
    }
}

struct TodoItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoItemScreen(viewModel: CreateTodoItemScreenViewModel())
        }
    }
}
