//
//  AddNewTask.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 13/01/23.
//

import SwiftUI

struct AddNewTask: View {
  
    @EnvironmentObject var taskModel: TaskViewModel
    //MARK:All environment values in one variable
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading,spacing: 10){
                Text("Add Task")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading){
                        Button{
                            env.dismiss()
                        }label: {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                    }
                
                    .overlay(alignment: .trailing){
                        Button{
                            if let editTask = taskModel.editTask{
                                env.managedObjectContext.delete(editTask)
                                try? env.managedObjectContext.save()
                                env.dismiss()
                            }
                            
                            
                        }label: {
                            Image(systemName: "trash")
                                .font(.title3)
                                .foregroundColor(.red)
                        }
                        .opacity(taskModel.editTask == nil ? 0 : 1)
                    }
                VStack(alignment: .leading, spacing: 12){
                    Text("Task Title")
                        .font(.title3)
                        .foregroundColor(.gray)
                    TextField("", text: $taskModel.taskTitle)
                        .frame(maxWidth: .infinity)
                        .padding(.top,1)
                    Rectangle()
                        .fill(.black.opacity(0.7))
                        .frame(height: 1)
                }
                .padding(.vertical)
                VStack(alignment: .leading, spacing: 12){
                    Text("Date")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Text(taskModel.taskDeadLine.formatted(date: .abbreviated, time: .omitted) + ", " + taskModel.taskDeadLine.formatted(date: .omitted, time: .shortened))
                    
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.top,8)
//                    Rectangle()
//                        .fill(.black.opacity(0.7))
//                        .frame(height: 1)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .overlay(alignment: .bottomTrailing){
                    Button{
                        taskModel.showDatePicker.toggle()
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                    }
                }
                .overlay(alignment: .bottom){
                    Rectangle()
                        .fill(.black.opacity(0.7))
                        .frame(height: 1)
                        .offset(y: 5)
                }
                VStack(alignment: .leading, spacing: 12){
                    Text("Task Color")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    //MARK:simple card colors
                    let colors: [String] = ["Yellow", "Green", "Blue","Purple", "Red", "Orange","Pink","Sky","Till"]
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing:20), count: 3), spacing: 15){
                        ForEach(colors,id: \.self){ color in
                            Rectangle()
                                .fill(Color(color))
                                .frame(width: 70, height: 25)
                                .background{
                                    if taskModel.taskColor == color{
                                        Rectangle()
                                            .strokeBorder(.gray)
                                            .padding(-3)
                                    }
                                }
                                .contentShape(Circle())
                                .onTapGesture {
                                    taskModel.taskColor = color
                                }
                            
                        }
                        
                        
                        
                    }
                    .padding(.top,10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,30)
                
              
                    .padding(.vertical,10)
  
               
               
                
                .padding(.top,10)
              
                
                // MARK: sample TaskType
//                let taskTypes: [String] = ["Basic", "Urgent", "Important"]
//                VStack(alignment: .leading, spacing: 12){
//                    Text("TaskType")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                    HStack(spacing: 12){
//                        ForEach(taskTypes,id: \.self){type in
//                            Text(type)
//                                .font(.callout)
//                                .padding(.vertical,8)
//                                .frame(maxWidth: .infinity)
//                                .foregroundColor(taskModel.taskType == type ? .white : .black)
//                                .background{
//                                    if taskModel.taskType == type{
//                                        Capsule()
//                                            .fill(.black)
//                                            .matchedGeometryEffect(id: "TYPE", in: animation)
//                                    }else{
//                                        Capsule()
//                                            .strokeBorder(.black)
//                                    }
//                                }
//                            // animation effect
//                                .contentShape(Capsule())
//                                .onTapGesture {
//                                    withAnimation{taskModel.taskType = type}
//                                }
//                        }
//                    }
//                    .padding(.top,8)
//                }
                .padding(.vertical, 10)
                
              //  Divider()
                
                //MARK SaveButton
                
                Button{
                    //MARK: If success closing view
                    if taskModel.addTask(context: env.managedObjectContext){
                        env.dismiss()
                    }
                } label: {
                    Text("SaveTask")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,12)
                        .foregroundColor(.white)
                        .background{
                            Capsule()
                                .fill(.black)
                        }
                }
                .frame(maxHeight:.infinity, alignment: .bottom)
                .padding(.bottom,10)
                // Color lightway
                .disabled(taskModel.taskTitle == "")
                .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .overlay{
                ZStack {
                    if taskModel.showDatePicker{
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .onTapGesture {
                                taskModel.showDatePicker = false
                            }
                        //MARK: Disable Past Date
                        DatePicker.init("", selection: $taskModel.taskDeadLine, in: Date.now...Date.distantFuture)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .padding()
                            .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .padding()
                    }
                    
                }
                .animation(.easeInOut, value: taskModel.showDatePicker)
            }
        }
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
          
            .environmentObject(TaskViewModel())
    }
}
