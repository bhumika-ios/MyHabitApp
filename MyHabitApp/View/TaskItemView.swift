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
    
    @ObservedObject var task: Task
    
    @State private var doesClose = false
    @State private var isEditTaskOpen = false
    
    private func deleteTask(object: NSManagedObject) {
        PersistenceController.shared.delete(context: moc, object: object)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        if task.isCompleted{
                            VStack{
                                if task.title != nil {
                                    Text(task.title!)
                                        .strikethrough()
                                        .onTapGesture {
                                            isEditTaskOpen.toggle()
                                        }
                                        .sheet(isPresented: $isEditTaskOpen) {
                                          //  PublishTodoScreen(todo: todo)
                                        }
                                }
                                
                                
                                if task.description != nil {
                                    
                                    Text(task.description!)
                                        .font(.system(size: 14))
                                        .strikethrough()
                                }
                            }
                        } else {
                            VStack{
                                if task.title != nil {
                                    Text(task.title!)
                                        .onTapGesture {
                                            isEditTaskOpen.toggle()
                                        }
                                        .sheet(isPresented: $isEditTaskOpen) {
                                          //  PublishTodoScreen(todo: todo)
                                        }
                                }
                                
                                
                                if task.description != nil {
                                    
                                    Text(task.description!)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    if task.group != nil {
                        Text("\(task.category!.title!) | \(task.readableDoDate)")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 14))
                    }
                }
                
                Spacer()
                CheckboxView(defaultChecked: task.done, onToggle: {
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

let task = task.createFakeTask(category: Category())

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(task: task)
            .previewLayout(.sizeThatFits)
    }
}
