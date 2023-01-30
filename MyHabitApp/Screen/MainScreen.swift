//
//  MainScreen.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 30/01/23.
//

import SwiftUI

struct MainScreen: View {
    @FetchRequest(entity: Todo.entity(), sortDescriptors: []) private var todos: FetchedResults<Todo>
    
    @State private var searchValue = ""
    @State private var isAddGroupOpen = false
    @State var showAddBottomSheet = false
    @State private var isAddTodoOpen = false
    @State private var filteredByGroup: Group? = nil
    @State private var currentDay: Date = .init()
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ScrollView(.vertical, showsIndicators: false){
                        TimelineView()
                            .padding(15)
                    }
                    .safeAreaInset(edge: .top, spacing: 0){
                        HeaderView()
                    }
                }
                .overlay(alignment: .bottomTrailing){
                    
                    //MARK:Add button
                    Button{
                        //taskModel.OpenEditTask.toggle()
                        showAddBottomSheet.toggle()
                        //isAddTodoOpen = true
                    }label: {
                        Label{
                           
                        }icon: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                              
                               
                        }
                        
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(Color("Pink"))
                        .frame(width: 43,height: 43)
                        .cornerRadius(15)
                        .padding()
                        
                    }
                 
                }
            }
        }
        .sheet(isPresented: $showAddBottomSheet){
            if #available(iOS 16.0, *) {
                AddBottomSelectionSheet()
                    .presentationDetents([.height(180), .height(180)])
            } else {
                // Fallback on earlier versions
            }
        }
    }
    @ViewBuilder
        func HeaderView()->some View{
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text("Today")
                            .font(.system(size: 18))
                        //   .laila(22, .light)
                        
                        Text("Welcome, User")
                            .font(.system(size: 12))
                        //   .laila(14, .light)
                    }
                    .hAlign(.leading)
                }
                // - Today DAte in string
                Text(Date().toString("MMM YYYY"))
                // .laila(16, .medium)
                    .font(.system(size: 14))
                    .hAlign(.leading)
                    .padding(.top, 15)
                
                ///- Current week Row
                WeekRow()
            }
            .padding(15)
            .background{
                
                VStack(spacing: 0){
                    Color.white
                    ///- Gradient opacity background
                    /// give a nice gradient effect at its bottom.
                    Rectangle()
                        .fill(.linearGradient(colors: [
                            .white,
                            .clear], startPoint: .top, endPoint: .bottom))
                        .frame(height: 20)
                }
                .ignoresSafeArea()
            }
        
    }
    @ViewBuilder
        func WeekRow()->some View{
            HStack(spacing: 0){
                ForEach(Calendar.current.currentWeek){weekDay in
                    let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                    VStack(spacing: 2){
                        // Text(weekDay.string)
                        Text(weekDay.string.prefix(3))
                        //   .laila(14, .medium)
                            .font(.system(size: 14))
                        Text(weekDay.date.toString("dd"))
                        // .laila(16, status ? .medium : .regular)
                            .font(.system(size: 14))
                        Rectangle()
                            .fill(.black)
                            .cornerRadius(20)
                            .frame(width: 15, height: 2)
                            .opacity(status ? 1 : 0)
                            .offset(y:4)
                    }
                    ///- Highlighting the currently active day
                    .foregroundColor(status ? Color(.white) : .gray)
                    // capsule shape
                    .frame(width: 45, height: 50)
                    .background{
                        ZStack{
                            if status{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(status ? Color("Pink") : Color.gray)
                                
                            }
                            
                        }
                    }
                    .hAlign(.center)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //                    withAnimation(.easeInOut(duration: 0.3)){
                        //                        currentDay = weekDay.date
                        //                    }
                        withAnimation{
                            currentDay = weekDay.date
                        }
                    }
                    
                }
            }
            .padding(.vertical,10)
            .padding(.horizontal, -15)
        
    }
    @ViewBuilder
    func TimelineViewRow(_ date: Date)->some View{
        HStack(alignment: .top){
            Text(date.toString("h a"))
              //  .laila(14, .regular)
                .font(.system(size: 14))
                .frame(width: 45, alignment: .leading)
            /// - filtering tasks
            let calendar = Calendar.current
            let filteredTasks = todos.filter{
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.doDate ?? Date()).hour,
                   /// - current day
                   hour == taskHour && calendar.isDate($0.doDate ?? Date(), inSameDayAs: currentDay){
                  /// - filtering tasks based on hour and also verifying whether the date is the same as the selected week day
                    return true
                }
                return false
            }
            if filteredTasks.isEmpty{
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            }else{
                /// - task view
                VStack(spacing: 10){
                    ForEach(filteredTasks){ task in
                       ListItemView(todo: task)
                    }
                }
            }
            
        }
        .hAlign(.leading)
        .padding(.vertical,15)
    }
    func TimelineView()->some View{
        ScrollViewReader{ proxy in
            
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
                VStack{
                    ForEach(hours, id: \.self){hour in
                        TimelineViewRow(hour)
                }
           
            }
            /// - because the timeline view beginds at 12 a.m, we want it to begin at 12. pm which is midday, so we use scrollviewreader proxy to set it to mid day
                .onAppear(){
                    proxy.scrollTo(midHour)
                }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
// MARK: View Extensions
extension View{
    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: Date Extension
extension Date{
    func toString(_ format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
//MARK: Calendar extension
extension Calendar{
    ///- return 24 hours in a day
    /// so when we get the start of the day, which means 0:00 with the help of this we can easily retrive the 24 - hours dates.
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay){
                hours.append(date)
            }
        }
        return hours
    }
    ///- Retuen current week in array format
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else{ return []}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString("EEEE") // - EEEE return the weekday symbol (e.g , Monday) from the given date
                let isToday = self.isDateInToday(day)
                // so the logic is to retrive the week first day and with the calendars adding method we are getting the subsequent seven dates from the strat date
                week.append(.init(string: weekDaySymbol, date: day))
            }
        }
        return week
    }
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
