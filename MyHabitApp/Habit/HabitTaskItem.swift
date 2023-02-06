//
//  HabitTaskItem.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 06/02/23.
//

import SwiftUI
import CoreData

struct HabitItemView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var habit: Habit
    
    @State private var doesClose = false
    @State private var isEditTaskOpen = false
    
    private func deleteTask(object: NSManagedObject) {
        PersistenceController.shared.delete(context: moc, object: object)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                 
                       
                            VStack(alignment: .leading){
                                if habit.title != nil {
                                    Text(habit.title!)
                                       // .strikethrough()
                                        .onTapGesture {
                                            isEditTaskOpen.toggle()
                                        }
                                        .sheet(isPresented: $isEditTaskOpen) {
                                          AddHabitScreen(habit: habit)
                                        }
                                }
                                
                                
                                if habit.remainderText != nil {
                                    
                                    Text(habit.remainderText!)
                                        .font(.system(size: 14))
                                       
                                }
                                HStack{
                                    if habit.category != nil {
                                        Text("\(habit.category!.title!) | \(habit.readableDoDate)")
                                      
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Habit")
                                       // .offset(x:8)
                                        //.padding(.horizontal)
                                    // .padding()
                                }
                                
                                .foregroundColor(Color.gray)
                                .font(.system(size: 14))
                            }
                        
//                            VStack(alignment: .leading){
//                                if task.taskName != nil {
//                                    Text(task.taskName!)
//                                        .onTapGesture {
//                                            isEditTaskOpen.toggle()
//                                        }
//                                        .sheet(isPresented: $isEditTaskOpen) {
//                                            AddTaskScreen(task: task)
//                                        }
//                                }
//
//
//                                if task.description != nil {
//
//                                    Text(task.taskDescription!)
//                                        .font(.system(size: 14))
//                                }
//                            }
                        
                    }
                   
                 
                    
                }
                
//                Spacer()
//                CheckboxView(defaultChecked: task.isCompleted, onToggle: {
//                    task.toggle(context: moc)
//                })
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
  //  }
}

let habit = Habit.createFakeHabit(category: Category())

struct HabitItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(task: task)
            .previewLayout(.sizeThatFits)
    }
}
