//
//  HabitViewModel.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 02/02/23.
//

//import SwiftUI
//import CoreData
//import UserNotifications
//
//class HabitViewModel: ObservableObject{
//    @Published var addNewHabit: Bool = false
//    @Published var title: String = ""
//    @Published var weekDays: [String] = []
//    @Published var isRemainderOn: Bool = false
//    @Published var remainderText: String = ""
//    @Published var dateAdded: Date = Date()
//    @State private var category: UUID? 
//    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
//    //add
//    func addHabit(context: NSManagedObjectContext)async->Bool{
//        let selectedCategory = categories.first(where: {$0.id == self.category!})
//        let habit = Habit(context: context)
//        habit.title = title
//        habit.weekDays = weekDays
//        habit.isRemainderOn = isRemainderOn
//        habit.remainderText = remainderText
//        habit.dateAdded = dateAdded
//        habit.category = selectedCategory
//        habit.notificationIDs = []
//        
//        if isRemainderOn{
//            if let ids = try? await scheduleNotification(){
//                habit.notificationIDs = ids
//                if let _ = try? context.save(){
//                    return true
//                }
//            }
//        }else{
//            if let _ = try? context.save(){
//                return true
//            }
//        }
//        return false
//    }
//    //add notification
//    func scheduleNotification()async throws->[String]{
//        let content = UNMutableNotificationContent()
//        content.title = "Habit Remainder"
//        content.subtitle = title
//        content.sound = UNNotificationSound.default
//        
//        //schedule id
//        var notificationIDs: [String] = []
//        let calendar = Calendar.current
//        let weekdaySymbols: [String] = calendar.weekdaySymbols
//        
//        //notification
//        for weekDay in weekDays{
//            let id = UUID().uuidString
//            let hour = calendar.component(.hour, from: dateAdded)
//            let min = calendar.component(.hour, from: dateAdded)
//            let day = weekdaySymbols.firstIndex{ currentDay in
//                return currentDay == weekDay
//                
//            } ?? -1
//            if day != -1{
//                var components = DateComponents()
//                components.hour = hour
//                components.minute = min
//                components.weekday = day + 1
//                
//                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
//                
//                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
//                
//                try await UNUserNotificationCenter.current().add(request)
//                
//                notificationIDs.append(id)
//            }
//        }
//        return notificationIDs
//    }
//    
//    // erasing content
//    func resetData(){
//        title =  ""
//        weekDays = []
//        isRemainderOn = false
//        dateAdded = Date()
//        remainderText = ""
//    }
//    //done button
//    func doneStatus()->Bool{
//        let remainderStatus = isRemainderOn ? remainderText == "" : false
//        if title == "" || weekDays.isEmpty || remainderStatus{
//            return false
//        }
//        return true
//    }
//}
//
