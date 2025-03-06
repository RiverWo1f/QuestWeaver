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
    private let fileManager = FileManager.default
    
    init() {
        loadWorlds()
    }
    
    // Get the documents directory path
    private func getDocumentsDirectory() -> URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // Get the worlds directory path, creating it if needed
    private func getWorldsDirectory() -> URL {
        let worldsPath = getDocumentsDirectory().appendingPathComponent("Worlds")
        
        if !fileManager.fileExists(atPath: worldsPath.path) {
            try? fileManager.createDirectory(at: worldsPath, withIntermediateDirectories: true)
        }
        
        return worldsPath
    }
    
    // Save a new world
    func saveWorld(_ world: WorldEditorData) {
        let encoder = JSONEncoder()
        let worldURL = getWorldsDirectory().appendingPathComponent("\(world.id.uuidString).json")
        
        do {
            let data = try encoder.encode(world)
            try data.write(to: worldURL)
            loadWorlds()
        } catch {
            print("Error saving world: \(error)")
        }
    }
    
    // Load all worlds
    private func loadWorlds() {
        let worldsPath = getWorldsDirectory()
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: worldsPath,
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
        let worldURL = getWorldsDirectory().appendingPathComponent("\(id.uuidString).json")
        
        do {
            try fileManager.removeItem(at: worldURL)
            loadWorlds()
        } catch {
            print("Error deleting world: \(error)")
        }
    }
    
    // Check if a world name already exists
    func worldNameExists(_ name: String) -> Bool {
        return worlds.contains { $0.name.lowercased() == name.lowercased() }
    }
}

