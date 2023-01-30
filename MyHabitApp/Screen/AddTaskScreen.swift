//
//  AddTaskScreen.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 30/01/23.
//

import SwiftUI

struct AddTaskScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    @Environment(\.self) var env
    @State private var color = Color.indigo
    @State private var systemIcon = "calendar"
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var category: UUID?
    @State private var taskDate = Date()
    @State private var isAddCategoryOpen = false
    @State private var backtoHome = false
    
    var task: Task? = nil
    
    init (task: Task? = nil) {
        if let safeTask = task {
            self.task = safeTask
            self._taskName = .init(initialValue: safeTask.taskName!)
            self._taskDescription = .init(initialValue: safeTask.taskDescription!)
            self._taskDate = .init(initialValue: safeTask.taskDate!)
            self._category = .init(initialValue: safeTask.category!.id)
        }
    }
    
    private func publishTask() {
        if self.category == nil {
            return
        }
        
        let selectedCategory = categories.first(where: {$0.id == self.category!})
        
        if task != nil {
            task?.taskName = taskName
            task?.taskDescription = taskDescription
            task?.category = selectedCategory
            task?.taskDate = taskDate
            
            PersistenceController.shared.save(context: moc)
        } else {
            PersistenceController.shared.createTask(context: moc, category: selectedCategory!, taskName: taskName, taskDescription: taskDescription ,doDate: date)
        }
        
       // dismiss()
           
          
    }
    var body: some View {
        NavigationView {
            Form {
                TextField("TaskName", text: $taskName)
                TextField("TaskDescription", text: $taskDescription)
                HStack(spacing: 20){
                  //  HStack{
                        Picker("Select Category", selection: $category) {
                            
                            ForEach(categories) {
                                
                                Text($0.title!).tag($0.id)
                                CategoryIconView(systemIcon: $0.systemIcon! , color: $0.color != nil ? Color(hex: $0.color!)! : Color.pink)
                            }
                        }
                        
                   // }
                    
                }
                
                DatePicker(
                    "Do Date",
                    selection: $taskDate,
                    displayedComponents: [.date]
                )
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button (action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                
              
                ToolbarItem (placement: .primaryAction) {
                    Button (action:{ publishTask()
                        backtoHome.toggle()
                    }) {
                        Text("Done")
//                            .onTapGesture {
//                                backtoHome.toggle()
//                            }
                            .fullScreenCover(isPresented: $backtoHome){
                                                }content: {
                                                    MainScreen()
                                                        //.environmentObject(taskModel)
                                                }
                    }
                    
//
                }
            }
            .navigationTitle("Publish Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
               // .overlay(alignment: .trailing){
                    Button{
                        if let editTask =  task {
                            env.managedObjectContext.delete(editTask)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                        
                        
                    }label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                // data filled show delete icon else not show
                    .opacity( task == nil ? 0 : 1)
               // }
            }
        }
    }
}

struct AddTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskScreen()
    }
}
