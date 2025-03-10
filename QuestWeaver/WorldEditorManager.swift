//
//  WorldEditorManager.swift
//  QuestWeaver
//
//  Created by Roger Barron on 6/3/2025.
//
//  This file manages the saving, loading, and deletion of world editor data.
//  It handles:
//  - File system operations for world saves
//  - JSON encoding/decoding of world data
//  - World list management
//  - Duplicate name checking
//  
//  The manager acts as a central point for all world editor data operations,
//  ensuring consistent data handling across the app.
//

import Foundation
import SwiftUI

class WorldEditorManager: ObservableObject {
    @Published var worlds: [WorldEditorData] = []
    let maxWorlds = 10
    
    init() {
        loadWorldsFromUserDefaults()
    }
    
    // Get the documents directory path
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // Get the worlds directory path, creating it if needed
    private func getWorldsDirectory() -> URL {
        let worldsPath = getDocumentsDirectory().appendingPathComponent("Worlds")
        
        if !FileManager.default.fileExists(atPath: worldsPath.path) {
            try? FileManager.default.createDirectory(at: worldsPath, withIntermediateDirectories: true)
        }
        
        return worldsPath
    }
    
    // Save a new world
    func saveWorld(_ world: WorldEditorData) {
        if worlds.count < maxWorlds {
            // Add new world to the end of the array
            worlds.append(world)
            saveWorldsToUserDefaults()
        }
    }
    
    private func saveWorldsToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(worlds) {
            UserDefaults.standard.set(encoded, forKey: "savedWorlds")
        }
    }
    
    private func loadWorldsFromUserDefaults() {
        if let savedWorlds = UserDefaults.standard.data(forKey: "savedWorlds"),
           let decodedWorlds = try? JSONDecoder().decode([WorldEditorData].self, from: savedWorlds) {
            worlds = decodedWorlds
        }
    }
    
    // Load all worlds
    private func loadWorlds() {
        let worldsPath = getWorldsDirectory()
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: worldsPath,
                                                             includingPropertiesForKeys: nil)
            worlds = fileURLs.compactMap { url in
                guard url.pathExtension == "json" else { return nil }
                
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    return try decoder.decode(WorldEditorData.self, from: data)
                } catch {
                    print("Error loading world at \(url): \(error)")
                    return nil
                }
            }
        } catch {
            print("Error loading worlds: \(error)")
            worlds = []
        }
    }
    
    // Delete a world
    func deleteWorld(withId id: UUID) {
        // Remove the world from the array
        worlds.removeAll { $0.id == id }
        // Save the updated array to UserDefaults
        saveWorldsToUserDefaults()
    }
    
    // Check if a world name already exists
    func worldNameExists(_ name: String) -> Bool {
        return worlds.contains { $0.name.lowercased() == name.lowercased() }
    }
}

