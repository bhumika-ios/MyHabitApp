//
//  DisplayCategoryView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 25/01/23.
//

import SwiftUI

struct DisplayCategoryView: View {
    //@StateObject var catModel: CategoryViewModel = .init()
   // @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.title, ascending: false)], predicate: nil, animation: .easeInOut) var categories: FetchedResults<Category>
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var searchValue = ""
    @State private var isAddGroupOpen = false
    @State private var isAddTodoOpen = false
    @State private var filteredByCategory: Category? = nil
    private let categoryCardColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 5)
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    // Text("gyhdgvvcdv")
                    ScrollView{
                        LazyVGrid(columns: categoryCardColumns, spacing: 10){
                        ForEach(categories) {cat in
                            
                            CardView(category: cat,
                                     isFilteredByCategory: cat == filteredByCategory
                                     , onCategoryTap: { g in
                                if filteredByCategory == g{
                                    filteredByCategory = nil
                                }else{
                                    filteredByCategory = g
                                }
                            })
                        }
                    }
                        //                    CardView(
                        //                        group: group,
                        //                        isFilteredByGroup: group == filteredByGroup,
                        //                        onGroupTap: { g in
                        //                            if filteredByGroup == g {
                        //                                filteredByGroup = nil
                        //                            } else {
                        //                                filteredByGroup = g
                        //                            }
                        //                        })
                    }
                }
            }
            //            .overlay(alignment: .leading){
            //
            //                //MARK:Add button
            //                Button{
            //                    //taskModel.OpenEditTask.toggle()
            //                    showAddBottomSheet.toggle()
            //
            //                }label: {
            //                    Label{
            //                        //                        Text("Add Task")
            //                        //                            .font(.callout)
            //                        //                            .fontWeight(.semibold)
            //                    }icon: {
            //                        Image(systemName: "plus")
            //                            .resizable()
            //                            .frame(width: 20, height: 20)
            //                            .padding()
            //                        //.fontWeight(.semibold)
            //
            //                    }
            //
            //                    .foregroundColor(.white)
            //                    .padding(.vertical, 12)
            //                    .padding(.horizontal)
            //                    .background(Color("Pink"))
            //                    .frame(width: 43,height: 43)
            //                    .cornerRadius(15)
            //                    .padding()
            //
            //                }
            //                .offset(x: 50,y: 300)
            //            }
            //            .fullScreenCover(isPresented: $showAddBottomSheet){
            //                    AddCategory(placeholder: "title")
            //                    .environmentObject(catModel)
            //                      //  .presentationDetents([ .height(180)])
            //                }
            .toolbar {
                ToolbarItem (placement: .primaryAction) {
                    Button(action: { isAddTodoOpen = true }) {
                        Image(systemName: "plus.circle")
                            .sheet(isPresented: $isAddTodoOpen) {
                                AddCategoryScreen()
                            }
                    }
                }
            }
        }
            
        }
       

    
}

struct DisplayCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayCategoryView()
    }
}
//ZStack{
//    HStack{
//        //  let filteredCat = categories
//        Text("fsdesdfdse")
//        ForEach(categories){ cat in
//            CatRowView(cat: cat)
//        }
//    }
//    .overlay(alignment: .leading){
//
//        //MARK:Add button
//        Button{
//            //taskModel.OpenEditTask.toggle()
//            showAddBottomSheet.toggle()
//
//        }label: {
//            Label{
//                //                        Text("Add Task")
//                //                            .font(.callout)
//                //                            .fontWeight(.semibold)
//            }icon: {
//                Image(systemName: "plus")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .padding()
//                //.fontWeight(.semibold)
//
//            }
//
//            .foregroundColor(.white)
//            .padding(.vertical, 12)
//            .padding(.horizontal)
//            .background(Color("Pink"))
//            .frame(width: 43,height: 43)
//            .cornerRadius(15)
//            .padding()
//
//        }
//        .offset(x: 50,y: 300)
//        //MARK:Linear GradientBG
//        // .padding(.top, 10)
//        //  .frame(maxWidth: .infinity)
//        //                .background{
//        //                    LinearGradient(colors: [
//        //                        .white.opacity(0.05),
//        //                        .white.opacity(0.4),
//        //                        .white.opacity(0.7),
//        //                        .white
//        //                    ], startPoint: .top, endPoint: .bottom)
//        //                    .ignoresSafeArea()
//        //                }
//    }
//
//    .sheet(isPresented: $showAddBottomSheet){
//        AddCategory(placeholder: "title")
//            .presentationDetents([.height(180), .height(180)])
//    }
//
//}
