//
//  MyHabitAppApp.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 13/01/23.
//

import SwiftUI

@main
struct MyHabitAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
