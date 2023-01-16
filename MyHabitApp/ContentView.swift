//
//  ContentView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 13/01/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
    var body: some View {
        NavigationView{
            HomeView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
