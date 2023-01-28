//
//  CategoryViewModel.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 25/01/23.
//


import SwiftUI
import CoreData

class CategoryViewModel: ObservableObject{
    @Published var OpenEditCat: Bool = false
    @Published var OpenHomeCat: Bool = false
    @Published var markCat: Bool = false
    @Published var catTitle: String = ""
    //@Published var taskDescription: String = ""
   // @Published var taskColor: String = "Yellow"
    //@Published var taskDeadLine: Date = Date()
   // @Published var showDatePicker: Bool = false
    //    MARK: Editing exiting task data
    @Published var editCat: Category?
    @Published var tasks: Task?
    
    //MARK: Adding Task to core data
    func addCat(context: NSManagedObjectContext)->Bool{
        var category: Category!
        if let editCat = editCat {
            
            category = editCat
            
        }else{
            category = Category(context: context)
        }
        
        category.title = catTitle
        
       // task.taskDescription = taskDescription
      //  task.taskColor = taskColor
      //  task.taskDate = taskDeadLine
        // task.type = taskType
       // task.isCompleted = false
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    //MARK: Resetting Data
    func resetCatData(){
       // taskType = "Basic"
       // taskColor = "Yellow"
        catTitle = ""
      //  taskDescription = ""
       // taskDeadLine = Date()
    }
    //    MARK: existing setup data
        func setupCat(){
            if let editCat = editCat{
               
               // taskType = editTask.type ?? "Basic"
               // taskColor = editTask.taskColor ?? "Yellow"
                catTitle = editCat.title ?? ""
              //  taskDescription = editTask.taskDescription ?? ""
              //  taskDeadLine = editTask.taskDate ?? Date()
            }
        }
   
}
