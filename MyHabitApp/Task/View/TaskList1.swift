//
//  TaskList.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 28/01/23.
//

import SwiftUI

struct TaskList1: View {
    @FetchRequest private var tasks: FetchedResults<TaskList>
    
    var body: some View {
        ForEach(tasks) { task in
            TaskItemView(task: task)
        }
    }
    
    init(query: String, category: Category? = nil) {
        let sortByDate = NSSortDescriptor(key: #keyPath(TaskList.taskDate), ascending: false)
        
        if category != nil {
            if query.isEmpty {
                _tasks = FetchRequest<TaskList>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "group = %@", category!))
            } else {
                _tasks = FetchRequest<TaskList>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "group = %@ && title CONTAINS[cd] %@", category!, query))
            }
        } else if !query.isEmpty {
            _tasks = FetchRequest<TaskList>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "title CONTAINS[cd] %@", query))
        } else {
            _tasks = FetchRequest<TaskList>(sortDescriptors: [sortByDate])
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList1(query: "")
    }
}

