//
//  AddHabitScreen.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 31/01/23.
//

import SwiftUI


struct AddHabitScreen: View {
  //  @EnvironmentObject var habitModel: HabitViewModel
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    @Environment(\.self) var env
    @State private var color = Color.indigo
    @State private var systemIcon = "calendar"
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var title = ""
    @State private var remainderText = ""
    @State private var weekDays1 = ["Monday"]
    @State private var category: UUID?
    @State private var dateAdded = Date()
    @State private var isRemainderOn = false
    @State private var isAddCategoryOpen = false
    @State private var backtoHome = false
    
    var habit: Habit? = nil
    
    init (habit: Habit? = nil) {
        if let safeHabit = habit {
            self.habit = safeHabit
            self._title = .init(initialValue: safeHabit.title!)
            self._remainderText = .init(initialValue: safeHabit.remainderText!)
            self._weekDays1 = .init(initialValue: safeHabit.weekDays!)
            self._dateAdded = .init(initialValue: safeHabit.dateAdded!)
            self._category = .init(initialValue: safeHabit.category!.id)
        }
    }
    
    private func publishHabit() {
        if self.category == nil {
            return
        }
        
        let selectedCategory = categories.first(where: {$0.id == self.category!})
        
        if habit != nil {
            habit?.title = title
            habit?.remainderText = remainderText
            habit?.weekDays = weekDays1
            habit?.category = selectedCategory
            habit?.dateAdded = dateAdded
            
            PersistenceController.shared.save(context: moc)
        } else {
            PersistenceController.shared.createHabit(context: moc, category: selectedCategory!, title: title, remainderText: remainderText ,dateAdded: dateAdded, weekDays: weekDays1 )
        }
        
       // dismiss()
           
          
    }
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Name", text: $title)
                TextField("RemainText", text: $remainderText)
                HStack(spacing: 20){
                  //  HStack{
                        Picker("Select Category", selection: $category) {
                         //   HStack{
                                ForEach(categories) {
                                    
                                    Text($0.title!).tag($0.id)
                
                                //    CategoryIconView(systemIcon: $0.systemIcon! , color: $0.color != nil ? Color(hex: $0.color!)! : Color.pink).tag($0.id)
                             //   }
                            }
                          //  .padding()
                        }
                       
                        
                   // }
                    
                }
                VStack(alignment: .leading, spacing: 6){
                    Text("Frequency")
                        .font(.callout.bold())
                    var weekDays = Calendar.current.weekdaySymbols
                    HStack(spacing: 10){
                        ForEach(weekDays,id: \.self){day in
                            let index = weekDays1.firstIndex { value in
                                return value == day
                            } ?? -1
                            //Mark: Limiting to first 2 latters
                            Text(day.prefix(2))
//                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                               .frame(maxWidth: .infinity)
//                                .padding()
                                .background{
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(index != -1 ? Color("Pink") : .gray).opacity(0.5)
                                       // .fill(index != -1 ? Color(categories.color) : Color("TFBG").opacity(0.4))
                                }
                                .onTapGesture{
                                    withAnimation{
                                        if index != -1{
                                            weekDays1.remove(at: index)
                                        }else{
                                            weekDays1.append(day)
                                          
                                        }
                                    }
                                }
                            
                        }
                    }
                    .padding(.top, 15)
                }
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text("Remainder")
                            .fontWeight(.semibold)
                        Text("Just notification")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: $isRemainderOn){
                        
                    }
                    .labelsHidden()
                }
                
                HStack{
                   
                    DatePicker(
                        "Do Date",
                        selection: $dateAdded,
                        in: Date()...
                    )
                  //  Text(habitModel.dateAdded.formatted(date: .omitted, time: .shortened))
                }
               
                .frame(height: isRemainderOn ? nil : 0)
                .opacity(isRemainderOn ? 1 : 0)
//                .animation(.easeInOut, value: habitModel.isRemainderOn)
//                .frame(maxHeight: .infinity, alignment: .top)
//                .padding()
//                .navigationBarTitleDisplayMode(.inline)
                
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button (action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                
              
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button(action: { publishHabit()
                        backtoHome = true
                    })
                           {
                       Text("Done")
//
                        
                    }
                    .disabled(title == "")
                        
                    .fullScreenCover(isPresented: $backtoHome){
                                        }content: {
                                           DisplayHabitView()
                                                //.environmentObject(taskModel)
                                        }
            
//
                }
               
            }
            .navigationTitle("Habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
               // .overlay(alignment: .trailing){
                    Button{
                        if let editHabit =  habit {
                            env.managedObjectContext.delete(editHabit)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                        
                        
                    }label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                // data filled show delete icon else not show
                    .opacity( habit == nil ? 0 : 1)
               // }
            }
        }
    }
}

struct AddHabitScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitScreen()
           // .environmentObject(HabitViewModel())
    }
}
