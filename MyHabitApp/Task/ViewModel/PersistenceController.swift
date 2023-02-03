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

extension PersistenceController {
    func createTask(context: NSManagedObjectContext, category: Category, taskName: String,taskDescription : String, taskDate: Date) {
        let newTask = TaskList(context: context)
        newTask.category = category
        newTask.id = UUID()
        newTask.taskName = taskName
        newTask.taskDescription = taskDescription
      //  newTodo.createdAt = Date()
        newTask.taskDate = taskDate

        self.save(context: context)
    }
}
extension PersistenceController {
    func createHabit(context: NSManagedObjectContext, category: Category, title: String,remainderText : String, dateAdded: Date, weekDays : [String]) {
        let newHabit = Habit(context: context)
        newHabit.category = category
        newHabit.id = UUID()
        newHabit.title = title
        newHabit.weekDays = weekDays
        newHabit.remainderText = remainderText
      //  newTodo.createdAt = Date()
        newHabit.dateAdded = dateAdded

        self.save(context: context)
    }
}

