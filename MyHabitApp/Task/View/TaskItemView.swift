//
//  TaskItemView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 28/01/23.
//

import SwiftUI
import CoreData

struct TaskItemView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var task: TaskList
    
    @State private var doesClose = false
    @State private var isEditTaskOpen = false
    
    private func deleteTask(object: NSManagedObject) {
        PersistenceController.shared.delete(context: moc, object: object)
       
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        if task.isCompleted{
                            VStack(alignment: .leading){
                                if task.taskName != nil {
                                    Text(task.taskName!)
                                        .strikethrough()
                                       
                                }
                                
                                
                                if task.taskDescription != nil {
                                    
                                    Text(task.taskDescription!)
                                        .font(.system(size: 14))
                                        .strikethrough()
                                }
                                VStack(alignment: .leading){
                                    HStack{
                                        if task.category != nil {
                                            Text("\(task.category!.title!) | \(task.readableDoDate)")
                                                .strikethrough()
                                          
                                        }
                                        
                                        Spacer()
                                        
                                        Text("Task")
                                            .offset(x:24)
                                            //.padding(.horizontal)
                                        // .padding()
                                    }
                                    
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 14))
                                }
                                .multilineTextAlignment(.leading)
                            }
                        } else {
                            VStack(alignment: .leading){
                                if task.taskName != nil {
                                    Text(task.taskName!)
//                                        .onTapGesture {
//                                            isEditTaskOpen.toggle()
//                                        }
//                                        .sheet(isPresented: $isEditTaskOpen) {
//                                            AddTaskScreen(task: task)
//                                        }
                                }
                                
                                if task.taskDescription != nil {
                                    Text(task.taskDescription!)
                                        .font(.system(size: 14))
                                }
//                                if task.description != nil {
//
//                                    Text(task.taskDescription!)
//                                        .font(.system(size: 14))
//                                }
                                VStack(alignment: .leading){
                                    HStack{
                                        if task.category != nil {
                                            Text("\(task.category!.title!) | \(task.readableDoDate)")
                                          
                                        }
                                        
                                        Spacer()
                                        
                                        Text("Task")
                                            .offset(x:24)
                                            //.padding(.horizontal)
                                        // .padding()
                                    }
                                    
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 14))
                                }
                            }
                            .onTapGesture {
                                isEditTaskOpen.toggle()
                            }
                            .sheet(isPresented: $isEditTaskOpen) {
                              AddTaskScreen(task: task)
                            }
                        }
                    }
//                    VStack{
//                        HStack{
//                            if task.category != nil {
//                                Text("\(task.category!.title!) | \(task.readableDoDate)")
//
//                            }
//
//                            Spacer()
//
//                            Text("Task")
//                                .offset(x:24)
//                                //.padding(.horizontal)
//                            // .padding()
//                        }
//
//                        .foregroundColor(Color.gray)
//                        .font(.system(size: 14))
//                    }
                }
                
                Spacer()
                CheckboxView(defaultChecked: task.isCompleted, onToggle: {
                    task.toggle(context: moc)
                })
//                Image(systemName: "trash")
//                    .onTapGesture {
//                        deleteTodo(object: todo)
//                    }
            }
            Divider()
        }
//        .background{
//            ZStack(alignment: .leading){
//                Rectangle()
//                    .fill(todo.group!.color)
//            }
//        }
    }
}

let task = TaskList.createFakeTask(category: Category())

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(task: task)
            .previewLayout(.sizeThatFits)
    }
}
