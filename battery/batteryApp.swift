//
//  batteryApp.swift
//  battery
//
//  Created by Tofus on 2025/9/6.
//

import SwiftUI
import CoreData

@main
struct batteryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
