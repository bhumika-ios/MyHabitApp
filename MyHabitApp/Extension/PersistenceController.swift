//
//  PersistenceController.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 25/01/23.
//

import CoreData
import SwiftUI

extension PersistenceController {
    func createCategory(context: NSManagedObjectContext, title: String, symbolIcon: String, color: Color) {
        let group = Category(context: context)
        group.id = UUID()
        group.title = title
        group.color = color.toHex()
        group.systemIcon = symbolIcon

        self.save(context: context)
    }
}

//extension PersistenceController {
//    func createTodo(context: NSManagedObjectContext, group: Group, title: String, doDate: Date) {
//        let newTodo = Todo(context: context)
//        newTodo.group = group
//        newTodo.id = UUID()
//        newTodo.title = title
//      //  newTodo.createdAt = Date()
//        newTodo.doDate = doDate
//
//        self.save(context: context)
//    }
//}

