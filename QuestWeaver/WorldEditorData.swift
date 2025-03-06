//
//  WorldEditorData.swift
//  QuestWeaver
//
//  Created by Roger Barron on 6/3/2025.
//
//  This file defines the data structure for world editor saves.
//  It contains:
//  - Basic world information (name, dates)
//  - Map data storage
//  - Layer system for drawings and placed images
//  - Composite image storage for gameplay
//  
//  This structure is used to save and load world editor projects,
//  allowing users to create and edit their world maps across multiple sessions.
//

import Foundation
import UIKit

struct WorldEditorData: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let createdDate: Date
    let lastModifiedDate: Date
    
    // Map data
    var baseMapImage: Data?  // Base map image
    var layerData: [MapLayer]  // Array of layers containing drawings and placed images
    var compositeMapImage: Data?  // Final composited image for gameplay
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdDate = Date()
        self.lastModifiedDate = Date()
        self.layerData = []
    }
    
    // Add static func == for Equatable conformance
    static func == (lhs: WorldEditorData, rhs: WorldEditorData) -> Bool {
        return lhs.id == rhs.id
    }
}

// Separate structure for map layers
struct MapLayer: Codable, Identifiable {
    let id: UUID
    let name: String
    var drawingData: Data?  // Drawing paths/shapes
    var placedImages: [PlacedImage]  // Images placed on this layer
    var isVisible: Bool
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.placedImages = []
        self.isVisible = true
    }
}

// Structure for images placed on layers
struct PlacedImage: Codable, Identifiable {
    let id: UUID
    let imageData: Data
    let position: CGPoint
    let size: CGSize
    let rotation: Double
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, position, size, rotation
    }
    
    // Custom coding for CGPoint and CGSize
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        imageData = try container.decode(Data.self, forKey: .imageData)
        let positionArray = try container.decode([CGFloat].self, forKey: .position)
        position = CGPoint(x: positionArray[0], y: positionArray[1])
        let sizeArray = try container.decode([CGFloat].self, forKey: .size)
        size = CGSize(width: sizeArray[0], height: sizeArray[1])
        rotation = try container.decode(Double.self, forKey: .rotation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(imageData, forKey: .imageData)
        try container.encode([position.x, position.y], forKey: .position)
        try container.encode([size.width, size.height], forKey: .size)
        try container.encode(rotation, forKey: .rotation)
    }
}

