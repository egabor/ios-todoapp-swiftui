//
//  TodoItemCell.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import SwiftUI

struct TodoItemCell: View {
    let todoItem: TodoItem

    var body: some View {
        VStack(alignment: .leading) {
            title
            description
        }
    }

    var title: some View {
        Text(todoItem.title)
            .strikethrough(todoItem.isCompleted)
    }

    @ViewBuilder
    var description: some View {
        if let description = todoItem.description {
            Text(description)
                .font(.footnote)
                .strikethrough(todoItem.isCompleted)
        }
    }
}

struct TodoItemCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemCell(todoItem: .previewObject())
    }
}
