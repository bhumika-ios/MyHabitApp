//
//  TaskListData.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 30/01/23.
//

import SwiftUI

struct TaskListData: View {
    @State private var searchValue = ""
    @State private var filteredByCategory: Category? = nil
    @State private var isAddCategoryOpen = false
    @State private var isAddTaskOpen = false
    var body: some View {
        NavigationView {
            ScrollView {
                SectionTitleView(title: "")
                
                TaskList1(query: searchValue, category: filteredByCategory)
            }
        
        .padding(.leading)
        .padding(.trailing)
        .searchable(text: $searchValue, placement: .toolbar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem (placement: .primaryAction) {
                Button(action: { isAddTaskOpen = true }) {
                    Image(systemName: "plus.circle")
                        .sheet(isPresented: $isAddTaskOpen) {
                            AddTaskScreen()
                        }
                    }
                }
            }
        }
    }
}

struct TaskListData_Previews: PreviewProvider {
    static var previews: some View {
        TaskListData()
    }
}
