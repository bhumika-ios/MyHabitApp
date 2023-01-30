//
//  CardView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 25/01/23.
//

import SwiftUI

struct CardView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var category: Category
    var isFilteredByCategory = false
    var onCategoryTap: (Category) -> Void
    
    @State private var isEditCategoryOpen = false
    
    var body: some View {
        VStack {
            HStack {
               CategoryIconView(systemIcon: category.systemIcon ?? "calendar", color: category.color != nil ? Color(hex: category.color!)! : Color.pink)
                Spacer()
                
//                if category.tasks != nil {
//                    Text("\(category.tasks!.count)")
//                        .foregroundColor(.primary)
//                        .bold()
//                }
            }
            
            
            if category.title != nil {
                HStack {
                    Text(category.title!)
                        .font(.system(size: 12))
                        .bold()
                    Spacer()
                }
            }
        }
        .padding(10)
//        .background(Color(UIColor.systemGray6))
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color(isFilteredByCategory ? UIColor.systemGray5 : UIColor.systemGray6), lineWidth: 10)
//        )
//        .cornerRadius(10)
        .onTapGesture {
            withAnimation {
                onCategoryTap(category)
            }
        }
        .contextMenu {
            VStack {
                Button("Edit Category") {
                    isEditCategoryOpen.toggle()
                }
                Button("Delete Category") {
                    withAnimation {
                        PersistenceController.shared.delete(context: moc, object: category)
                    }
                }
            }
        }
        .sheet(isPresented: $isEditCategoryOpen) {
          //  PublishCategoryScreen(group: group)
        }
    }
}

let category = Category.createFakeCategory()

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(category: category, onCategoryTap: {_ in})
            .previewLayout(.sizeThatFits)
    }
}
