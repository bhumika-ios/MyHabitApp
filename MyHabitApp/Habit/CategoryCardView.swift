//
//  CategoryCardView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 31/01/23.
//

import SwiftUI

struct CategoryCardView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var category: Category
    var isFilteredByGroup = false
    var onGroupTap: (Category) -> Void
    
    @State private var isEditCategoryOpen = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack {
                    CategoryIconView(systemIcon: category.systemIcon ?? "calendar", color: category.color != nil ? Color(hex: category.color!)! : Color.pink)
                    if category.title != nil {
                        HStack {
                            Text(category.title!)
                                .font(.system(size: 18))
                                .bold()
                   // Spacer()
                }
                
                
              
                       
                        Spacer()
                        
//                        if category.product != nil {
//                            Text("\(category.product!.count)")
//                                .foregroundColor(.primary)
//                                .bold()
//                        }
                    }
                }
                
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(10)
        .background(Color(UIColor.systemGray6))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(isFilteredByGroup ? UIColor.systemGray5 : UIColor.systemGray6), lineWidth: 10)
        )
        .cornerRadius(10)
//        .onTapGesture {
//            withAnimation {
//                onGroupTap(category)
//            }
//        }
        .onTapGesture {
            isEditCategoryOpen.toggle()
        }
//        .contextMenu {
//            VStack {
//                Button("Edit category") {
//                    isEditGroupOpen.toggle()
//                }
//                Button("Delete category") {
//                    withAnimation {
//                        PersistenceController.shared.delete(context: moc, object: category)
//                    }
//                }
//            }
//        }
        .sheet(isPresented: $isEditCategoryOpen) {
            AddHabitScreen()
             //   .environmentObject(HabitViewModel())
          //  PublishCategoryScreen(category: category)
        }
    }
}

let category1 = Category.createFakeCategory()

struct GroupCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(category: category1, onGroupTap: {_ in})
            .previewLayout(.sizeThatFits)
    }
}

