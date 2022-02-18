//
//  TodoListScreen.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 12..
//

import SwiftUI

struct TodoListScreen: View {
    @StateObject var viewModel: TodoListScreenViewModel = .init()

    // MARK: - LEVEL 0 Views: Body & Content Wrapper

    var body: some View {
        content
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: { addNewTodoItemButton })
            .contentLoading(viewModel.isLoading)
            .disabled(viewModel.isLoading)
            .sheet(
                isPresented: $viewModel.isPresentingTodoDetails,
                content: { todoDetails() }
            )
            .alert(
                viewModel.errorAlertTitle,
                isPresented: $viewModel.showError,
                actions: { Text(viewModel.errorAlertOkButtonTitle) },
                message: { Text(viewModel.errorMessage) }
            )
    }

    var content: some View {
        VStack {
            list
            showOrHideCompletedItemsButton
                .padding(.horizontal)
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var addNewTodoItemButton: some View {
        Button(
            action: viewModel.createTodoItem,
            label: { Image(systemName: "plus.circle") }
        )
    }

    var list: some View {
        List {
            ForEach(viewModel.todoItems, content: cell)
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.loadTodoList()
        }
    }

    func cell(for todoItem: TodoItem) -> some View {
        NavigationLink(
            destination: { todoDetails(todoItem) },
            label: { TodoItemCell(todoItem: todoItem) }
        )
    }

    var showOrHideCompletedItemsButton: some View {
        Button(
            action: viewModel.showOrHideCompletedItems,
            label: { Text(viewModel.showOrHideCompletedButtonTitle) }
        )
            .buttonStyle(PrimaryButtonStyle())
    }

    @ViewBuilder
    func todoDetails(_ todoItem: TodoItem? = nil) -> some View {
        if let todoItem = todoItem {
            TodoDetailsScreen(viewModel: viewModel.editTodoItemViewModel(todoItem: todoItem))
        } else {
            NavigationView {
                TodoDetailsScreen(viewModel: viewModel.createTodoItemViewModel())
            }
        }
    }
}

struct TodoListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodoListScreen()
    }
}
