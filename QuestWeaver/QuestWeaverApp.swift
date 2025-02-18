//
//  QuestWeaverApp.swift
//  QuestWeaver
//
//  Created by Roger Barron on 26/1/2025.
//

import SwiftUI
import GameKit

@main
struct QuestWeaverApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var gameCenterManager = GameCenterManager.shared
    
    init() {
        // Force landscape orientation
        if #available(iOS 16.0, *) {
            UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
            }
        }
        
        // Additional orientation lock
        AppDelegate.orientationLock = .landscape
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameCenterManager)
        }
    }
}

// Add AppDelegate to handle orientation
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.landscape
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
