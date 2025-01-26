//
//  QuestWeaverApp.swift
//  QuestWeaver
//
//  Created by Roger Barron on 26/1/2025.
//

import SwiftUI

@main
struct QuestWeaverApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
