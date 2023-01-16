//
//  Home.swift
//  TaskManager
//
//  Created by Bhumika Patel on 10/05/22.
//

import SwiftUI

struct HomeView: View {
    //@StateObject var taskModel: TaskkViewModel = .init()
    @StateObject var taskModel: TaskViewModel = .init()
    //MARK: Matched Geometry Names
    @Namespace var animation
  
    
//    MARK: Fetching Task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.taskDate, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
//    MARK: Environment values
    @Environment(\.self) var env
    @State var isOrdinary: Bool = true
    @State private var currentDay: Date = .init()
    var body: some View {
        ZStack{
//            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    ScrollView(.vertical, showsIndicators: false){
                        TimelineView()
                            .padding(15)
                        //Later will come
                    }
                    .safeAreaInset(edge: .top, spacing: 0){
                        HeaderView()
                    }
//                    .frame(maxWidth: .infinity,  alignment: .leading)
//                    .padding(.vertical)
                    
                    
                    //            CustomSegmentedBar()
                    //                .padding(.top,5)
                    //MARK: Task View
                    //TaskView()
                    
                }
               // .padding()
//            }
            .overlay(alignment: .bottomTrailing){
                
                //MARK:Add button
                Button{
                   // taskModel.openEditTask.toggle()
                    taskModel.OpenEditTask.toggle()
                    
                }label: {
                    Label{
//                        Text("Add Task")
//                            .font(.callout)
//                            .fontWeight(.semibold)
                    }icon: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                            //.fontWeight(.semibold)
                           
                    }
                    
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color("Pink"))
                    .frame(width: 52,height: 55)
                    .cornerRadius(20)
                    .padding()
                    
                }
               // .offset(x: -10,y: -10)
                //MARK:Linear GradientBG
               // .padding(.top, 10)
              //  .frame(maxWidth: .infinity)
//                .background{
//                    LinearGradient(colors: [
//                        .white.opacity(0.05),
//                        .white.opacity(0.4),
//                        .white.opacity(0.7),
//                        .white
//                    ], startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
//                }
            }
                .fullScreenCover(isPresented: $taskModel.OpenEditTask){
                taskModel.resetTaskData()
            } content: {
                AddNewTask()
                    .environmentObject(taskModel)
            }
        }
        
    }
    ///- HeaderView
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
    /// - timelineview row
    @ViewBuilder
    func TimelineViewRow(_ date: Date)->some View{
        HStack(alignment: .top){
            Text(date.toString("h a"))
              //  .laila(14, .regular)
                .font(.system(size: 14))
                .frame(width: 45, alignment: .leading)
            /// - filtering tasks
            let calendar = Calendar.current
            let filteredTasks = tasks.filter{
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.taskDate ?? Date()).hour,
                   /// - current day
                   hour == taskHour && calendar.isDate($0.taskDate ?? Date(), inSameDayAs: currentDay){
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
                       TaskRowView(task: task)
                    }
                }
            }
            
        }
        .hAlign(.leading)
        .padding(.vertical,15)
    }
//    MARK: TaskView

 //   @ViewBuilder
//    func TaskView()->some View{
//        LazyVStack(spacing: 20){
//           //MARK:
//            DynamicFilteredView(currentTab: taskModel.currentTab){ (task: Task) in
//                TaskRowView(task: task)
//            }
//        }
//        .padding(.top,20)
//    }
//    @ViewBuilder
//    func TaskRow(_ task: Task)->some View{
//        VStack(alignment: .leading, spacing: 8){
//            Text(task.title.uppercased())
//                //.laila(16, .regular)
//                .foregroundColor(task.taskColor.color)
//
//            if task.task != ""{
//                Text(task.taskDescription)
//                    .laila(14, .light)
//                    .foregroundColor(task.taskCategory.color.opacity(0.8))
//            }
//        }
//        .hAlign(.leading)
//        .padding(12)
//        .background{
//            ZStack(alignment: .leading){
//                // first dark color
//                Rectangle()
//                    .fill(task.taskCategory.color)
//                    .frame(width: 5)
//                Rectangle()
//                    .fill(task.taskCategory.color.opacity(0.25))
//
//            }
//        }
//    }
//    MARK: Task RowView
    func TaskRowView(task: Task)->some View{
        VStack(alignment: .leading, spacing: 5){
            HStack(alignment: .bottom, spacing: 0){
//                Text(task.type ?? "")
//                    .font(.callout)
//                    .padding(.vertical,5)
//                    .padding(.horizontal)
//                    .background{
//                            Capsule()
//                           .fill(.white.opacity(0.3))
//                    }
              //  Spacer()
                Text(task.taskName ?? "")
                    //.font(.title3)
                    .font(.system(size: 16))
                   // .foregroundColor(task.color)
                    .padding(.vertical,10)
                Spacer()
//                MARK:  Edit button only for noncomleted task
                //&& taskModel.currentTab != "Failed Task"
               // if !task.isCompleted {
                    Button{
                        taskModel.editTask = task
                   
                        taskModel.OpenEditTask = true
                        taskModel.setupTask()
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
             //   }
                
            }
            
           
            
            HStack(alignment: .bottom, spacing: 0){
                VStack(alignment: .leading, spacing: 5){
                    Label {
                        Text((task.taskDate ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.taskDate ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
               // CheckBoxView().environmentObject(taskModel)
                //&& taskModel.currentTab != "Failed Task"
                Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                    .onTapGesture {
                        
                            task.isCompleted.toggle()
                        
                    }
//                if !taskModel.markTask {
//                    Button{
////                        MARK: updating Coredata
//                       // task.isCompleted = true
//                        taskModel.markTask.toggle()
//                        try? context.save()
////                        try? env.managedObjectContext.save()
//                    } label: {
////                        Circle()
////                            .strokeBorder(.black,lineWidth: 1.5)
////                            .frame(width: 20, height: 20)
////                            .contentShape(Circle())
//                        Image(systemName: taskModel.markTask ? "checkmark.circle.fill" : "circle")
//                          .resizable()
//                          .frame(width: 20, height: 20)
//                          .accentColor(.black)
//                    }
//                }
            }
            
        }
        .padding()
       .padding(. vertical,-15)
//        .padding(.trailing,10)
        .frame(maxWidth: .infinity)
        .background{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color(task.taskColor ?? "Yellow"))
                    .frame(width: 5)
                //   RoundedRectangle(cornerRadius: 12, style: .continuous)
                //  .fill(Color(task.color.opacity(0.25) as! CGColor))
                Rectangle()
                    .fill(Color(task.taskColor ?? "Yellow" )).opacity(0.25)
            }
        }
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
    //MARK: Custom Segmented Bar
//    @ViewBuilder
//    func CustomSegmentedBar()->some View{
//        let tabs = ["Today", "Upcoming", "Task Done", "Failed Task"]// In case missed card
//        HStack(spacing: 20){
//            ForEach(tabs,id: \.self){tab in
//                Text(tab)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .scaleEffect(0.9)
//                    .foregroundColor(taskModel.currentTab == tab ? .white: .black)
//                    .padding(.vertical,6)
//                    .background{
//                        if taskModel.currentTab == tab{
//                            Capsule()
//                                .fill(.black)
//                                .matchedGeometryEffect(id: "TAB", in: animation)
//                        }
//                    }
//                    .contentShape(Capsule())
//                    .onTapGesture {
//                        withAnimation{taskModel.currentTab = tab}
//                    }
//            }
//        }
//    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
