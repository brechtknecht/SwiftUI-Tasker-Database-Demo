//
//  TaskerApp.swift
//  Tasker
//
//  Created by Felix Tesche on 25.05.21.
//

import SwiftUI

@main
struct TaskerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TaskStore(realm: RealmPersistent.initializer()))
        }
    }
}
