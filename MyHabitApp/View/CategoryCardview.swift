//
//  CategoryCardview.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 18/01/23.
//

//import SwiftUI
//
//struct CategoryCardview: View {
//    @Environment(\.managedObjectContext) private var moc
//    
//    @ObservedObject var group: CategoryForTask
//    var isFilteredByGroup = false
//    var onGroupTap: (CategoryForTask) -> Void
//    
//    @State private var isEditGroupOpen = false
//    var body: some View {
//        VStack {
//            HStack {
//                GroupIconView(systemIcon: group.systemIcon ?? "calendar", color: group.color != nil ? Color(hex: group.color!)! : Color.pink)
//                
//                Spacer()
//                
//                if group.task != nil {
//                    Text("\(group.task!)")
//                        .foregroundColor(.primary)
//                        .bold()
//                }
//            }
//            
//            if group.title != nil {
//                HStack {
//                    Text(group.title!)
//                        .font(.system(size: 18))
//                        .bold()
//                    Spacer()
//                }
//            }
//        }
//        .padding(10)
//        .background(Color(UIColor.systemGray6))
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color(isFilteredByGroup ? UIColor.systemGray5 : UIColor.systemGray6), lineWidth: 10)
//        )
//        .cornerRadius(10)
//        .onTapGesture {
//            withAnimation {
//                onGroupTap(group)
//            }
//        }
//        .contextMenu {
//            VStack {
//                Button("Edit Group") {
//                    isEditGroupOpen.toggle()
//                }
//                Button("Delete Group") {
//                    withAnimation {
//                        PersistenceController.shared.delete(context: moc, object: group)
//                    }
//                }
//            }
//        }
//        .sheet(isPresented: $isEditGroupOpen) {
//            CategoryView(group: group)
//        }
//    }
//}
//let group = CategoryForTask.createFakeGroup()
//struct CategoryCardview_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCardview(group: group, onGroupTap: {_ in})
//    }
//}
