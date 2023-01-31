//
//  AddHabitScreen.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 31/01/23.
//

import SwiftUI

struct AddHabitScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    @Environment(\.self) var env
    @State private var color = Color.indigo
    @State private var systemIcon = "calendar"
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var title = ""
    @State private var remainderText = ""
    @State private var category: UUID?
    @State private var dateAdded = Date()
    @State private var isAddCategoryOpen = false
    @State private var backtoHome = false
    
    var habit: Habit? = nil
    
    init (habit: Habit? = nil) {
        if let safeHabit = habit {
            self.habit = safeHabit
            self._title = .init(initialValue: safeHabit.title!)
            self._remainderText = .init(initialValue: safeHabit.remainderText!)
            self._dateAdded = .init(initialValue: safeHabit.dateAdded!)
            self._category = .init(initialValue: safeHabit.category!.id)
        }
    }
    
    private func publishHabit() {
        if self.category == nil {
            return
        }
        
        let selectedCategory = categories.first(where: {$0.id == self.category!})
        
        if habit != nil {
            habit?.title = title
            habit?.remainderText = remainderText
            habit?.category = selectedCategory
            habit?.dateAdded = dateAdded
            
            PersistenceController.shared.save(context: moc)
        } else {
            PersistenceController.shared.createHabit(context: moc, category: selectedCategory!, title: title, remainderText: remainderText ,dateAdded: dateAdded )
        }
        
       // dismiss()
           
          
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddHabitScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitScreen()
    }
}
