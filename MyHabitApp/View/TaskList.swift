//
//  TaskList.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 28/01/23.
//

import SwiftUI

struct TaskList: View {
    @FetchRequest private var tasks: FetchedResults<Task>
    
    var body: some View {
        ForEach(tasks) { task in
            TaskItemView(task: task)
        }
    }
    
    init(query: String, category: Category? = nil) {
        let sortByDate = NSSortDescriptor(key: #keyPath(Task.taskDate), ascending: false)
        
        if category != nil {
            if query.isEmpty {
                _tasks = FetchRequest<Task>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "group = %@", category!))
            } else {
                _tasks = FetchRequest<Task>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "group = %@ && title CONTAINS[cd] %@", category!, query))
            }
        } else if !query.isEmpty {
            _tasks = FetchRequest<Task>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "title CONTAINS[cd] %@", query))
        } else {
            _tasks = FetchRequest<Task>(sortDescriptors: [sortByDate])
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(query: "")
    }
}

