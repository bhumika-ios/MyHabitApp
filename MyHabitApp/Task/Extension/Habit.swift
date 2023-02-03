//
//  Habit.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 03/02/23.
//

import Foundation
import CoreData

extension Habit {
    static func createFakeHabit(category: Category, context: NSManagedObjectContext? = nil) -> Habit {
        let newHabit = context != nil ? Habit(context: context!) : Habit()
        newHabit.category = category
        newHabit.id = UUID()
        newHabit.title = "Some Habit"
        newHabit.remainderText = "Some Text"
     
        newHabit.dateAdded = Date()
        
        return newHabit
    }
    
    var readableDoDate: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "MMM dd,yyyy"
            
            if (self.dateAdded != nil) {
                return df.string(from: self.dateAdded!)
            }
            
            return ""
        }
    }
    
    func toggle(context: NSManagedObjectContext) {
        self.isRemainderOn.toggle()
        
        PersistenceController.shared.save(context: context)
    }
}
