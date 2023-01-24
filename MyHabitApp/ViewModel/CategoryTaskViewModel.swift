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
}
