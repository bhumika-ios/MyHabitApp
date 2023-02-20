////
////  NotificationHabitHandler.swift
////  MyHabitApp
////
////  Created by Bhumika Patel on 08/02/23.
////
//
import Foundation
import UserNotifications
import UIKit
import CoreData
import SwiftUI

class NotificationHandler{
  
    //@FetchRequest(entity: TaskList.entity(), sortDescriptors: []) private var tasks: FetchedResults<TaskList>
    func requestAuthorization() {
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { authorizarionSuccess, error in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                } else {
                    print("Authorization request success")
                }
            }
        }
    func scheduleNotification(weekday: [String], date: Date, type: String,timeInterval: Double = 10, title: String, body: String) -> [String] {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var notificationsIDs: [String] = []

        let calendar = Calendar.current
        let weekDaySybmols: [String] = calendar.weekdaySymbols

        for weekDay in weekday {
            let id = UUID().uuidString
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let day = weekDaySybmols.firstIndex { currentDay in
                return currentDay == weekDay
            } ?? -1

            var components = DateComponents()
            components.hour = hour
            components.minute = minute
            components.weekday = day + 1

            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        //    try await UNUserNotificationCenter.current().add(request)

            notificationsIDs.append(id)
            UNUserNotificationCenter.current().add(request)

        }

        return notificationsIDs
    }
    func removePendingRequest(request: UNNotificationRequest) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
    }
            func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {
        
                let state : UIApplication.State = application.applicationState
                    if (state == .inactive || state == .background) {
                        // go to screen relevant to Notification content
                        print("background")
                    } else {
                        // App is in UIApplicationStateActive (running in foreground)
                        print("foreground")
        
                    }
                }
    
    class NotificationDelegate: NSObject,ObservableObject,UNUserNotificationCenterDelegate{
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.badge,.banner,.sound])
        }
    
    
    
    
    }

//    class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = self
//    }
}
