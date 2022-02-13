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
            .contentLoading(viewModel.isLoading)
    }

    var content: some View {
        VStack {
            title
            list
            showOrHideCompletedItemsButton
                .padding(.horizontal)
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var title: some View {
        Text(viewModel.title)
            .font(.headline)
    }

    var list: some View {
        List {
            ForEach(viewModel.todoItems, content: TodoItemCell.init)
        }
        .listStyle(.plain)
    }

    var showOrHideCompletedItemsButton: some View {
        Button(
            action: viewModel.showOrHideCompletedItems,
            label: { Text(viewModel.showOrHideCompletedButtonTitle) }
        )
            .buttonStyle(PrimaryButtonStyle())
    }
}

struct TodoListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodoListScreen()
    }
}
