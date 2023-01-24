//
//  AddCategory.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 24/01/23.
//

import SwiftUI

struct AddCategory: View {
//    @State private var color = Color.indigo
//    @State private var systemIcon = "calendar"
    @EnvironmentObject var categoryModel: CategoryTaskViewModel
    private let systemIcons = [
        "calendar", "book.closed", "bookmark", "graduationcap", "cart",
        "display", "clock", "network", "phone", "heart"
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    VStack(alignment: .center, spacing: 20){
                        CategoryIconView(systemIcon: categoryModel.systemIcon, color: categoryModel.color, size: .lg)
                        TextField("Title", text: $categoryModel.categoryTitle)
                            .padding(10)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                  //  LazyVGrid(columns: columns, spacing: 20)
                    
                }
            }
        }
    }
}

struct AddCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddCategory()
            .environmentObject(CategoryTaskViewModel())
    }
}
