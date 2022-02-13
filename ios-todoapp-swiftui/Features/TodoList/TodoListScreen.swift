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
    }

    var content: some View {
        VStack {
            title
            list
            showOrHideCompletedItemsButton
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var title: some View {
        Text(viewModel.title)
            .font(.headline)
    }

    var list: some View {
        List {
            ForEach(viewModel.todoItems) { item in
                VStack(alignment: .leading) {
                    if item.isCompleted {
                        Text(item.title)
                            .strikethrough()
                        if let description = item.description {
                            Text(description)
                                .font(.footnote)
                                .strikethrough()
                        }
                    } else {
                        Text(item.title)
                        if let description = item.description {
                            Text(description)
                                .font(.footnote)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }

    var showOrHideCompletedItemsButton: some View {
        Button(
            action: viewModel.showOrHideCompletedItems,
            label: { Text(viewModel.showOrHideCompletedButtonTitle) }
        )
    }
}

struct TodoListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodoListScreen()
    }
}
