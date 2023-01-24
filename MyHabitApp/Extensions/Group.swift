//
//  Group.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 18/01/23.
//

//
import Foundation
import CoreData

extension Category {
    static func createFakeCategory(context: NSManagedObjectContext? = nil) -> Category {
        let group = context != nil ? Category(context: context!) : Category()
        group.id = UUID()
        group.title = "Some Group"
        group.color = "#2f42d6"
        group.systemIcon = "list.bullet.circle.fill"
        
        return group
    }
}
