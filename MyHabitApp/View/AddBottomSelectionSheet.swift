//
//  AddBottomSelectionSheet.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 16/01/23.
//
import SwiftUI

struct AddBottomSelectionSheet: View {
    @State private var isAddTodoOpen = false
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                Button{
                    
                } label: {
                    HStack{
                        Image(systemName: "heart.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                        VStack(alignment: .leading){
                            Text("Habit")
                            HStack{
                                Text("Activity that repeated over time. It has detailed tracking and statistic.")
                                    .font(.footnote)
                              
                                
                            }
                            .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 10, height: 15)
                    }
                }
                .foregroundColor(.black)
                Divider()
                    .foregroundColor(.black)
                Button{
                  //  taskModel.OpenEditTask.toggle()
                    isAddTodoOpen = true
                } label: {
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                        VStack(alignment: .leading){
                            Text("Task")
                            HStack{
                                Text("Single instance activity without tracking over time.")
                                    .font(.footnote)
                                
                                
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 10, height: 15)
                    }
                }
                .foregroundColor(.black)
            }
        }
        .padding()
        .sheet(isPresented: $isAddTodoOpen) {
            AddTaskScreen()
        }
      
    }
    
}

struct AddBottomSelectionSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddBottomSelectionSheet()
    }
}
