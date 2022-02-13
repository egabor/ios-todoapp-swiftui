//
//  TodoItem.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import TodoAppNetwork

public typealias TodoItem = Todo.Item.Response

extension TodoItem: Identifiable {}
