////
////  CategoryTaskViewModel.swift
////  MyHabitApp
////
////  Created by Bhumika Patel on 18/01/23.
////
//
import SwiftUI
import CoreData

class CategoryTaskViewModel: ObservableObject{
    @Published var categoryTitle: String = ""
    @Published  var color = Color.indigo
    @Published  var systemIcon = "calendar"
    
      let colors = [
        Color.indigo, Color.red, Color.blue, Color.cyan, Color.yellow,
        Color.green, Color.mint, Color.purple, Color.teal, Color.pink,
    ]
    
    let systemIcons = [
        "calendar", "book.closed", "bookmark", "graduationcap", "cart",
        "display", "clock", "network", "phone", "heart"
    ]
}
