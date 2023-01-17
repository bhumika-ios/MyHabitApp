//
//  TabView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 16/01/23.
//

import SwiftUI

struct TabHomeView: View {
    var body: some View {
        TabView {
           HomeView()
                .tabItem{
                    Image(systemName: "list.bullet.rectangle")
                    Text("Today")
                }
            Text("Habit")
                .tabItem{
                    Image(systemName: "heart.circle")
                    Text("Habit")
                }
            Text("Task")
                .tabItem{
                    Image(systemName: "checkmark.circle")
                    Text("Task")
                }
            Text("Setting")
                .tabItem{
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
        }
        .tint(Color("Pink"))
    }
}

struct TabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeView()
    }
}
