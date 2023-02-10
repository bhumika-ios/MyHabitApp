//
//  AppDelegate.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 10/02/23.
//

import Foundation
import UIKit
// MARK: foreground notification show in app
class AppDelegate: NSObject,ObservableObject, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    configureUserNotifications()
    return true
  }
}
// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner,.sound])
    }
    private func configureUserNotifications() {
      UNUserNotificationCenter.current().delegate = self
      // 1
      let dismissAction = UNNotificationAction(
        identifier: "dismiss",
        title: "Dismiss",
        options: []
      )
      let markAsDone = UNNotificationAction(
        identifier: "markAsDone",
        title: "Mark As Done",
        options: []
      )
      // 2
      let category = UNNotificationCategory(
        identifier: "OrganizerPlusCategory",
        actions: [dismissAction, markAsDone],
        intentIdentifiers: [],
        options: []
      )
      // 3
      UNUserNotificationCenter.current().setNotificationCategories([category])
    }
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//            guard let idToDelete = userInfo["del-id"] as? String else {
//                completionHandler(.noData)
//                return
//            }
//
//            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [idToDelete])
//            completionHandler(.noData)
//        }
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let taskData = userInfo["Task"] as? Data {
//          if let task = try? JSONDecoder().decode(TaskModel.self, from: taskData) {
//            // 3
//            TaskViewModel().remove(task: task)
//          }
//        }
//        completionHandler()
//    }
    
}
