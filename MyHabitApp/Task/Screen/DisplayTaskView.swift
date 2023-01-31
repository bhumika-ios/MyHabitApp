//
//  DisplayTaskView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 30/01/23.
//

import SwiftUI

struct DisplayTaskView: View {
    @State private var searchValue = ""
    @State private var isAddCategoryOpen = false
    @State var showAddBottomSheet = false
    @State private var isAddTaskOpen = false
    @State private var filteredByCategory: Category? = nil
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ScrollView{
                        SectionTitleView(title: "")
                        
                        TaskList(query: searchValue, category: filteredByCategory)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .overlay(alignment: .bottomTrailing){
                
                //MARK:Add button
                Button{
                    //taskModel.OpenEditTask.toggle()
                    showAddBottomSheet.toggle()
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
                    
                }
                
            }
            .sheet(isPresented: $showAddBottomSheet){
                if #available(iOS 16.0, *) {
                    AddBottomSelectionSheet()
                        .presentationDetents([.height(180), .height(180)])
                } else {
                    // Fallback on earlier versions
                }
            }
            .navigationTitle("Task List")
        }
    }
}

struct DisplayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayTaskView()
    }
}
