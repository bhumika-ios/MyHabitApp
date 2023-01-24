//
//  CategoryDisplayView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 18/01/23.
//

//import SwiftUI
//
//struct CategoryDisplayView: View {
//    @FetchRequest(entity: CategoryForTask.entity(), sortDescriptors: []) private var groups: FetchedResults<CategoryForTask>
//    
//    @State private var searchValue = ""
//    @State private var isAddGroupOpen = false
//    @State private var isAddTodoOpen = false
//    @State private var filteredByGroup: CategoryForTask? = nil
//    
//    private let groupCardColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack (spacing: 10) {
//                    LazyVGrid(columns: groupCardColumns, spacing: 10) {
//                        ForEach(groups) {group in
//                            CategoryCardview(
//                                group: group,
//                                isFilteredByGroup: group == filteredByGroup,
//                                onGroupTap: { g in
//                                    if filteredByGroup == g {
//                                        filteredByGroup = nil
//                                    } else {
//                                        filteredByGroup = g
//                                    }
//                                })
//                        }
//                    }
//                    
//                   // SectionTitleView(title: "All")
//                 //   Text("All")
//                    
//                   //TodoList(query: searchValue, group: filteredByGroup)
//                }
//            }
//            .padding(.leading)
//            .padding(.trailing)
//            .searchable(text: $searchValue, placement: .toolbar)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem (placement: .navigationBarTrailing) {
//                    Button(action: { isAddGroupOpen = true }) {
//                        Image(systemName: "plus.rectangle.on.folder")
//                            .sheet (isPresented: $isAddGroupOpen) {
//                                CategoryView()
//                            }
//                    }
//                }
////                ToolbarItem (placement: .primaryAction) {
////                    Button(action: { isAddTodoOpen = true }) {
////                        Image(systemName: "plus.circle")
////                            .sheet(isPresented: $isAddTodoOpen) {
////                                PublishTodoScreen()
////                            }
////                    }
////                }
//            }
//            .navigationViewStyle(.automatic)
//        }
//    }
//}
//
//struct CategoryDisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDisplayView()
//    }
//}
