//
//  AddCategory.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 24/01/23.
//

import SwiftUI

struct AddCategory: View {
    @State private var color = Color.indigo
    @State private var systemIcon = "calendar"
    private let systemIcons = [
        "calendar", "book.closed", "bookmark", "graduationcap", "cart",
        "display", "clock", "network", "phone", "heart"
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    VStack(alignment: .center, spacing: 20){
                        CategoryIconView(systemIcon: systemIcon, color: color, size: .lg)
                    }
                }
            }
        }
    }
}

struct AddCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddCategory()
    }
}
