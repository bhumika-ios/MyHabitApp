//
//  HabitHomeView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 31/01/23.
//

import SwiftUI

struct HabitHomeView: View {
    @FetchRequest(entity: Habit.entity(), sortDescriptors: []) private var habits: FetchedResults<Habit>
    var body: some View {
        VStack(spacing: 0){
            Text("Habits")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
               
            ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false){
                VStack(spacing: 15){
                   
                }
            }
        }
        .overlay(alignment: .trailing){
            //MARK:Add button
            Button{
                //taskModel.OpenEditTask.toggle()
               // showAddBottomSheet.toggle()
                //isAddTodoOpen = true
            }label: {
                Label{
                    
                }icon: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                    
                    
                }
                
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color("Pink"))
                .frame(width: 43,height: 43)
                .cornerRadius(15)
                .padding()
                .offset(y: 300)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct HabitHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HabitHomeView()
    }
}
