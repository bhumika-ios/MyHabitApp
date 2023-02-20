//
//  NewHabit.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 31/01/23.
//

import SwiftUI
extension Category{
    public var itemsArray:[Habit]{
        let set = habits as? Set<Habit> ?? []
        return set.sorted{
            $0.dateCreated! < $1.dateCreated!
        }
    }
}
struct NewHabit: View {
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var searchValue = ""
    @State private var isAddCategoryOpen = false
    @State private var isAddProductOpen = false
    @State private var filteredByCategory: Category? = nil
    
    private let groupCardColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 10) {
                    //LazyVGrid(columns: groupCardColumns, spacing: 10) {
                    VStack{
                        ForEach(categories) {category in
                            NavigationLink(destination: {
                                List(category.itemsArray){product in
                                    //Text(todo.title ?? "")
                                    
                                ScrollView{
                                    AddHabitScreen()
                                 //   ProductList(query: product.title ?? "", category: filteredByCategory)
                                }
                                }
                                .navigationBarTitle("Habit")
                                .toolbar {
                                    ToolbarItem (placement: .primaryAction) {
                                        Button(action: { isAddProductOpen = true }) {
                                            Image(systemName: "plus.circle")
                                                .sheet(isPresented: $isAddProductOpen) {
                                                  //  PublishProductScreen()
                                                   // AddHabitScreen()
                                                }
                                        }
                                    }
                                    
                                }
                            }, label: {
                                CategoryCardView(
                                    category: category,
                                    isFilteredByGroup: category == filteredByCategory,
                                    onGroupTap: { g in
                                        if filteredByCategory == g {
                                            filteredByCategory = nil
                                        } else {
                                            filteredByCategory = g
                                        }
                                    })
                            })
                            
                        }
                        //  }
                    }
//                    SectionTitleView(title: "")
//
//                    TodoList(query: searchValue, group: filteredByGroup)
                }
            }
            .padding(.leading)
            .padding(.trailing)
            //.searchable(text: $searchValue, placement: .toolbar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button(action: { isAddCategoryOpen = true }) {
                        Image(systemName: "plus.circle")
                            .sheet (isPresented: $isAddCategoryOpen) {
                               // PublishCategoryScreen()
                            }
                    }
                }
//                ToolbarItem (placement: .primaryAction) {
//                    Button(action: { isAddTodoOpen = true }) {
//                        Image(systemName: "plus.circle")
//                            .sheet(isPresented: $isAddTodoOpen) {
//                                PublishTodoScreen()
//                            }
//                    }
//                }
            }
            .navigationTitle("Category List")
            .navigationViewStyle(.automatic)
        }
    }
}

struct NewHabit_Previews: PreviewProvider {
    static var previews: some View {
        NewHabit()
    }
}
