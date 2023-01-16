//
//  TaskViewModel.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 16/01/23.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject{
    @Published var OpenEditTask: Bool = false
    @Published var markTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadLine: Date = Date()
    @Published var showDatePicker: Bool = false
    //    MARK: Editing exiting task data
    @Published var editTask: Task?
    @Published var tasks: Task?
    
    //MARK: Adding Task to core data
    func addTask(context: NSManagedObjectContext)->Bool{
        var task: Task!
        if let editTask = editTask {
            
            task = editTask
            
        }else{
            task = Task(context: context)
        }
        
        task.taskName = taskTitle
        task.taskColor = taskColor
        task.taskDate = taskDeadLine
        // task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    //MARK: Resetting Data
    func resetTaskData(){
       // taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadLine = Date()
    }
    //    MARK: existing setup data
        func setupTask(){
            if let editTask = editTask{
               
               // taskType = editTask.type ?? "Basic"
                taskColor = editTask.taskColor ?? "Yellow"
                taskTitle = editTask.taskName ?? ""
                taskDeadLine = editTask.taskDate ?? Date()
            }
        }
   
}
