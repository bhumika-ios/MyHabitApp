//
//  NotificationManager.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 13/02/23.
//

import Foundation
import UserNotifications
import UIKit
import CoreData
import SwiftUI

class NotificationHandler1{
 
    func askTaskNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if success {
                print("Access granted!")
                
            }else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func sendNotification(date: Date, type: String,timeInterval: Double = 10, title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    func removeScheduledNotification(task: TaskList) {
        let id = UUID().uuidString
        UNUserNotificationCenter.current()
                   .removePendingNotificationRequests(withIdentifiers:[id])
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
}
