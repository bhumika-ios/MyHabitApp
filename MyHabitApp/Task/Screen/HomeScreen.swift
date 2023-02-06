//
//  HomeScreen.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 30/01/23.
//

import SwiftUI
import CoreData

struct HomeScreen: View {

    
    var body: some View {
       // TodoTabScreen()
        TabView {
            MainScreen()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
            DisplayHabitView()
            
                 .tabItem {
                     Image(systemName: "star.circle")
                    
                     Text("Habit")
                 }
          
           DisplayTaskView()
           
                .tabItem {
                    Image(systemName: "checkmark.square")
                    
                    Text("Task")
                }
            AddCategoryScreen()
           
                .tabItem {
                    Image(systemName: "plus.rectangle.on.folder")
                    Text("Category")
                }
            
//           DisplayCategoryView()
//                .tabItem {
//                    Image(systemName: "chart.bar")
//                }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
