//
//  Task.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 30/01/23.
//

import Foundation
import CoreData

extension Task {
    static func createFakeTodo(category: Category, context: NSManagedObjectContext? = nil) -> Task {
        let newTask = context != nil ? Task(context: context!) : Task()
        newTask.category = category
        newTask.id = UUID()
        newTask.taskName = "Some Todo"
        newTask.taskDescription = "Some Des"
     
        newTask.taskDate = Date()
        
        return newTask
    }
    
    var readableDoDate: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "MMM dd,yyyy"
            
            if (self.taskDate != nil) {
                return df.string(from: self.taskDate!)
            }
            
            return ""
        }
    }
    
    func toggle(context: NSManagedObjectContext) {
        self.isCompleted.toggle()
        
        PersistenceController.shared.save(context: context)
    }
}
