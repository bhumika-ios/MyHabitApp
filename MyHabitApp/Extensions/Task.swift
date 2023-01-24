////
////  Task.swift
////  MyHabitApp
////
////  Created by Bhumika Patel on 18/01/23.
////
//
//import Foundation
//import CoreData
//
//extension Task {
//    static func createFakeTask(group: CategoryForTask, context: NSManagedObjectContext? = nil) -> Todo {
//        let newTask = context != nil ? Task(context: context!) : Task()
//        newTask.group = group
//        newTask.id = UUID()
//        newTask.title = "Some Todo"
//        newTodo.createdAt = Date()
//        newTodo.doDate = Date()
//        
//        return newTodo
//    }
//    
//    var readableDoDate: String {
//        get {
//            let df = DateFormatter()
//            df.dateFormat = "MMM dd,yyyy"
//            
//            if (self.doDate != nil) {
//                return df.string(from: self.doDate!)
//            }
//            
//            return ""
//        }
//    }
//    
//    func toggle(context: NSManagedObjectContext) {
//        self.done.toggle()
//        
//        PersistenceController.shared.save(context: context)
//    }
//}
