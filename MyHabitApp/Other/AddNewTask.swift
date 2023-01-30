////
////  AddNewTask.swift
////  MyHabitApp
////
////  Created by Bhumika Patel on 13/01/23.
////
//
//import SwiftUI
//
//struct AddNewTask: View {
//    let placeholder: String
//    let placeholder2: String
//    @State private var color: Color = .blue
//    @State private var category: UUID?
//    @EnvironmentObject var taskModel: TaskViewModel
//    //MARK:All environment values in one variable
//    @Environment(\.self) var env
//    @Namespace var animation
//  //  @State private var selectedCategory:[Category] = []
//    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
//    
//    var body: some View {
//        VStack(alignment: .leading){
//            VStack(alignment: .leading,spacing: 10){
//                VStack{
//                    Text("Add Task")
//                        .font(.title3.bold())
//                        .frame(maxWidth: .infinity)
//                        .overlay(alignment: .leading){
//                            Button{
//                                env.dismiss()
//                            }label: {
//                                Image(systemName: "chevron.left")
//                                    .font(.title3)
//                                    .foregroundColor(.black)
//                            }
//                            //.offset(x: -15)
//                        }
//                    
//                        .overlay(alignment: .trailing){
//                            Button{
//                                if let editTask = taskModel.editTask{
//                                    env.managedObjectContext.delete(editTask)
//                                    try? env.managedObjectContext.save()
//                                    env.dismiss()
//                                }
//                                
//                                
//                            }label: {
//                                Image(systemName: "trash")
//                                    .font(.title3)
//                                    .foregroundColor(.red)
//                            }
//                            .opacity(taskModel.editTask == nil ? 0 : 1)
//                        }
//                }
//                Spacer()
//                
//                ZStack(alignment: .leading){
//                    Text(placeholder)
//                        .font(.system(self.taskModel.taskTitle.isEmpty ? .title2 : .title3, design: .rounded))
////                        .font(.title3)
//                        .foregroundColor(.black.opacity(0.5))
//                        //.padding(.horizontal)
//                        .background(Color.white)
//                        .offset(y: self.taskModel.taskTitle.isEmpty ? 0 : -28)
//                        .scaleEffect(self.taskModel.taskTitle.isEmpty ? 1 : 0.9, anchor: .leading)
////                        .foregroundColor(.gray)
//                    TextField("", text: $taskModel.taskTitle)
//                        .font(.system(.title3, design: .rounded))
//                        .foregroundColor(.black)
//                       
////                        .frame(maxWidth: .infinity)
////                        .padding(.top,1)
////                    Rectangle()
////                        .fill(.black.opacity(0.7))
////                        .frame(height: 1)
//                      
//                }
//                .animation(.easeOut)
//                .padding(.horizontal)
//                .padding(.vertical, 10)
//                .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(self.taskModel.taskTitle.isEmpty ? .black.opacity(0.5) : .black, lineWidth: 1)
//                )
//                ZStack(alignment: .leading){
//                    Text(placeholder2)
//                        .font(.system(self.taskModel.taskDescription.isEmpty ? .title2 : .title3, design: .rounded))
////                        .font(.title3)
//                        .foregroundColor(.black.opacity(0.5))
//                        //.padding(.horizontal)
//                        .background(Color.white)
//                        .offset(y: self.taskModel.taskDescription.isEmpty ? 0 : -28)
//                        .scaleEffect(self.taskModel.taskDescription.isEmpty ? 1 : 0.9, anchor: .leading)
////                        .foregroundColor(.gray)
//                    TextField("", text: $taskModel.taskDescription)
//                        .font(.system(.title3, design: .rounded))
//                        .foregroundColor(.black)
//                       
////                        .frame(maxWidth: .infinity)
////                        .padding(.top,1)
////                    Rectangle()
////                        .fill(.black.opacity(0.7))
////                        .frame(height: 1)
//                      
//                }
//                .animation(.easeOut)
//                .padding(.horizontal)
//                .padding(.vertical, 10)
//                .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(self.taskModel.taskDescription.isEmpty ? .black.opacity(0.5) : .black, lineWidth: 1)
//                )
//                .padding(.vertical,10)
////                VStack{
////                    Text("Selected Category")
////                    ScrollView(.horizontal){
////                        LazyHStack{
////                            ForEach(selectedCategory){selectCategory in
////                                Button(action: {
////                                    if let indexToRemove = selectedCategory.firstIndex(of: selectCategory){
////                                        selectedCategory.remove(at: indexToRemove)
////                                    }
////                                },
////                                label: {
////                                    Text(selectCategory.title ?? "TagColorRed")
////                                })
////                                .tint(Color(selectCategory.color ?? ""))
////                                .buttonBorderShape(.roundedRectangle)
////                                .buttonStyle(.bordered)
////                                .controlSize(.large)
////                            }
////                        }
////                    }
////                    Text("Categories")
////                    ScrollView(.horizontal){
////                        LazyHStack{
////                            ForEach(categories){category in
////                                Button(action: {
////                                    selectedCategory.append(category)
////                                }, label: {
////                                    Text(category.title ?? "TagColorRed")
////
////                                })
////                                .tint(Color(category.color ?? ""))
////                                .buttonBorderShape(.roundedRectangle)
////                                .buttonStyle(.bordered)
////                                .controlSize(.large)
////                            }
////                        }
////                    }
////                }
//               // .padding(.vertical,10)
//                HStack{
//                    Text("Select Category")
//                        Spacer()
//                    Picker("select Category", selection: $category){
//                        ForEach(categories){
//                            Text($0.title!).tag($0.id)
//                        }
//                    }
//                }
//                .padding(.leading,10)
//                .overlay(alignment: .bottom){
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(.black.opacity(0.5), lineWidth: 1)
//                       // .fill(.black.opacity(0.5))
//                        .frame(width: 360, height:45)
//                        .offset(x: -5,y: 10)
//                        .padding(.leading,10)
//                }
//                .padding()
//                VStack(alignment: .leading, spacing: 12){
////                    Text("Date")
////                        .font(.title3)
////                        .foregroundColor(.black.opacity(0.5))
////                        .background(Color.white)
////                        .offset(y: -28)
////                        .scaleEffect(0.9, anchor: .leading)
//                    Text(taskModel.taskDeadLine.formatted(date: .abbreviated, time: .omitted) + ", " + taskModel.taskDeadLine.formatted(date: .omitted, time: .shortened))
//                        .padding()
//                        .font(.title3)
//                        .foregroundColor(.black)
//                        .fontWeight(.semibold)
//                        .padding(.top,8)
//                        .offset(y: -20)
//                        .padding(.vertical,1)
////                    Rectangle()
////                        .fill(.black.opacity(0.7))
////                        .frame(height: 1)
//                }
//                .padding(.vertical,-30)
//                .frame(maxWidth: .infinity,alignment: .leading)
//                .overlay(alignment: .bottomTrailing){
//                    Button{
//                        taskModel.showDatePicker.toggle()
//                    } label: {
//                        Image(systemName: "calendar")
//                            .foregroundColor(.black)
//                    }
//                    
//                    .offset(x: -5,y: -10)
//                }
//                .overlay(alignment: .bottom){
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(.black.opacity(0.5), lineWidth: 1)
//                       // .fill(.black.opacity(0.5))
//                        .frame(width: 360, height:45)
//                        .offset(x: -4,y: 1)
//                        .padding(.leading,10)
//                }
//                .padding(.bottom, 15)
////                VStack(alignment: .leading, spacing: 12){
////                    let colors: [String] = ["Yellow", "Green", "Blue","Purple", "Red", "Orange","Pink","Sky","Till"]
////                    ScrollView(.horizontal, showsIndicators: false){
////                        HStack(spacing: 15){
////                            
////                            ForEach(colors,id: \.self){ color in
////                                Circle()
////                                    .fill(Color(color))
////                                    .frame(width: 25, height: 25)
////                                    .background{
////                                        if taskModel.taskColor == color{
////                                            Circle()
////                                                .strokeBorder(.gray)
////                                                .padding(-3)
////                                        }
////                                    }
////                                    .contentShape(Circle())
////                                    .onTapGesture {
////                                        taskModel.taskColor = color
////                                    }
////                            }
////                        }
////                        .padding()
////                    }
////                }
////                ZStack{
////                    VStack{
////                        Image(systemName: "rectangle.fill")
////                            .resizable()
////                            .frame(width: 100, height: 20)
////                            .foregroundColor(color)
////                        ColorPicker("Color Picker", selection: $color)
////                    }
////                }
////                VStack(alignment: .leading, spacing: 12){
////                    Text("Task Color")
////                        .font(.title3)
////                        .foregroundColor(.gray)
////
////                    //MARK:simple card colors
////                    let colors: [String] = ["Yellow", "Green", "Blue","Purple", "Red", "Orange","Pink","Sky","Till"]
////                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing:20), count: 3), spacing: 15){
////                        ForEach(colors,id: \.self){ color in
////                            Circle()
////                                .fill(Color(color))
////                                .frame(width: 70, height: 25)
////                                .background{
////                                    if taskModel.taskColor == color{
////                                        Circle()
////                                            .strokeBorder(.gray)
////                                            .padding(-3)
////                                    }
////                                }
////                                .contentShape(Circle())
////                                .onTapGesture {
////                                    taskModel.taskColor = color
////                                }
////
////                        }
////
////
////
////                    }
////                    .padding(.top,10)
////                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.top,30)
//                
//              
//                    .padding(.vertical,10)
//  
//               
//               
//                
//               // .padding(.top,10)
//              
//                
//               
//               // .padding(.vertical, 10)
//                
//              //  Divider()
//                
//                //MARK SaveButton
//                
//                Button{
//                    //MARK: If success closing view
//                    if taskModel.addTask(context: env.managedObjectContext){
//                        taskModel.OpenHomeTask = true
//                        //env.dismiss()
//                    }
//                } label: {
//                    Text("SaveTask")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical,12)
//                        .foregroundColor(.white)
//                        .background{
//                            Capsule()
//                                .fill(.black)
//                        }
//                }
//                .frame(maxHeight:.infinity, alignment: .bottom)
//                .padding(.bottom,10)
//                // Color lightway
//                .disabled(taskModel.taskTitle == "")
//                .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
//            }
//            .frame(maxHeight: .infinity, alignment: .top)
//            .padding()
//            .overlay{
//                ZStack {
//                    if taskModel.showDatePicker{
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                            .ignoresSafeArea()
//                            .onTapGesture {
//                                taskModel.showDatePicker = false
//                            }
//                        //MARK: Disable Past Date
//                        DatePicker.init("", selection: $taskModel.taskDeadLine, in: Date.now...Date.distantFuture)
//                            .datePickerStyle(.graphical)
//                            .labelsHidden()
//                            .padding()
//                            .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
//                            .padding()
//                    }
//                    
//                }
//                .animation(.easeInOut, value: taskModel.showDatePicker)
//            }
//        }
//        .fullScreenCover(isPresented: $taskModel.OpenHomeTask){
//        }content: {
//            HomeView()
//                .environmentObject(taskModel)
//        }
//               // .presentationDetents([.large, .large])
//    
//    }
//}
//
//struct AddNewTask_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewTask(placeholder: "Task Name", placeholder2: "Task Description")
//          
//            .environmentObject(TaskViewModel())
//    }
//}
