//
//  WorldEditorLoadScreenIPhone.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

// No need for @_exported, just make sure the files are in the same target
struct WorldEditorLoadIPhone: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var worldManager = WorldEditorManager()
    @State private var showCreateWorldPopup = false
    @State private var showDeleteConfirmation = false
    @State private var worldName: String = ""
    @State private var showDuplicateAlert = false
    @State private var selectedWorldId: UUID?
    @FocusState private var isFocused: Bool
    @State private var showMaxWorldsAlert = false
    @State private var selectedWorldName: String?
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let isIPhoneSE = (screenSize.width <= 375 && screenSize.height <= 667) || (screenSize.width <= 667 && screenSize.height <= 375)
        let isIPhonePro = screenSize.height >= 844
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image(isIPhoneSE ? "worldEditorLoadBackgroundSE" : "worldEditorLoadBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(y: isIPhonePro ? -20 : 0)
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black, location: 0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            // Back button
            HStack {
                ZStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(isIPhoneSE ? "backButtonSE" : "backButtonIphone")
                            .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                    }
                }
                .offset(x: isIPhoneSE ? -45 : -29, y: isIPhoneSE ? -150 : -155)
                Spacer()
            }
            .ignoresSafeArea()
            
            // VStack for other buttons
            VStack(spacing: 20) {
                // Top button with text
                HStack {
                    ZStack {
                        Button {
                            if worldManager.worlds.count >= 10 {
                                showMaxWorldsAlert = true
                            } else {
                                showCreateWorldPopup = true
                            }
                        } label: {
                            ZStack {
                                Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                
                                Text("Create World")
                                    .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                    .foregroundColor(Color(hex: "f29412"))
                            }
                        }
                    }
                    .offset(x: isIPhoneSE ? -9 : 40)
                    Spacer()
                }
                .alert("Maximum Worlds Reached", isPresented: $showMaxWorldsAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Maximum limit of 10 worlds reached. Please delete a world before creating a new one.")
                }
                
                // Middle button with text
                HStack {
                    ZStack {
                        Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                            .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                        
                        Text("Load World")
                            .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                    .offset(x: isIPhoneSE ? -9 : 40)
                    Spacer()
                }
                
                // Bottom button with text
                HStack {
                    Button {
                        if selectedWorldId != nil {
                            // Set the selectedWorldName to the name of the world being deleted
                            if let world = worldManager.worlds.first(where: { $0.id == selectedWorldId }) {
                                selectedWorldName = world.name
                            }
                            showDeleteConfirmation = true
                        }
                    } label: {
                        ZStack {
                            Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                                .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                            
                            Text("Delete World")
                                .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                    .offset(x: isIPhoneSE ? -9 : 40)
                    Spacer()
                }
            }
            .offset(y: 20)
            .ignoresSafeArea()
            
            // Right side with world list
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: isIPhoneSE ? 10 : 15) {
                        ForEach(Array(worldManager.worlds.enumerated()), id: \.element.id) { index, world in
                            ZStack {
                                Image(isIPhoneSE ? "loadWorldBoxSE" : "loadWorldBox")
                                    .opacity(selectedWorldId == world.id ? 1 : 0)
                                
                                Text(world.name)
                                    .font(.custom("Papyrus", size: isIPhoneSE ? 18 : 22))
                                    .foregroundColor(.white)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedWorldId = world.id
                                withAnimation {
                                    scrollProxy.scrollTo(world.id, anchor: .center)
                                }
                            }
                            .frame(height: isIPhoneSE ? 50 : 60)
                            .id(world.id)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .simultaneousGesture(DragGesture().onChanged { _ in
                    selectedWorldId = nil
                })
                .frame(width: isIPhoneSE ? 260 : 280, height: isIPhoneSE ? 235 : 255)
                .offset(x: isIPhoneSE ? -20 : -51, y: isIPhoneSE ? 20 : 48)
            }
            
            // Popup overlay
            if showCreateWorldPopup {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                ZStack {
                    Image(isIPhoneSE ? "createWorldPopupSE" : "createWorldPopup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: isIPhoneSE ? 455 : 683)
                    
                    // Text input field
                    ZStack(alignment: .leading) {
                        if !isFocused && worldName.isEmpty {
                            Text("Name Your World")
                                .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        TextField("", text: $worldName)
                            .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                            .multilineTextAlignment(.leading)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .tint(.white)
                            .focused($isFocused)
                            .onChange(of: worldName) { newValue in
                                if newValue.count > 16 {
                                    worldName = String(newValue.prefix(16))
                                }
                            }
                    }
                    .offset(x: isIPhoneSE ? 200 : 285, y: isIPhoneSE ? -26 : -26)
                    
                    // Buttons
                    HStack(spacing: isIPhoneSE ? -50 : -40) {
                        // Create button (left)
                        Button {
                            if worldManager.worldNameExists(worldName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                showDuplicateAlert = true
                            } else {
                                let newWorld = WorldEditorData(name: worldName.trimmingCharacters(in: .whitespacesAndNewlines))
                                worldManager.saveWorld(newWorld)
                                worldName = ""
                                showCreateWorldPopup = false
                            }
                        } label: {
                            ZStack {
                                Image("worldEditorLoadPopupButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3)
                                
                                Text("Create")
                                    .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                    .foregroundColor(Color(hex: "f29412"))
                            }
                        }
                        .disabled(worldName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        
                        // Cancel button (right)
                        Button {
                            worldName = ""
                            showCreateWorldPopup = false
                        } label: {
                            ZStack {
                                Image("worldEditorLoadPopupButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3)
                                
                                Text("Cancel")
                                    .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                    .foregroundColor(Color(hex: "f29412"))
                            }
                        }
                    }
                    .offset(y: isIPhoneSE ? 100 : 100)
                }
                .ignoresSafeArea(.keyboard)
                
                // Add alert for duplicate names
                .alert("World Already Exists", isPresented: $showDuplicateAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("A world with this name already exists. Please choose a different name.")
                }
            }
            
            // Delete confirmation popup
            if showDeleteConfirmation {
                GeometryReader { geometry in
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    ZStack {
                        Image(isIPhoneSE ? "deleteWorldPopupSE" : "deleteWorldPopup")
                            .resizable()
                            .scaledToFit()
                        
                        // Display only the name of the world to be deleted in black
                        Text("\"\(selectedWorldName ?? "Unknown World")\"")
                            .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                            .foregroundColor(.black)
                            .padding(.bottom, 20) // Add some padding for spacing
                        
                        // Popup Buttons
                        HStack(spacing: 10) {
                            // Delete button (left)
                            Button {
                                if let id = selectedWorldId {
                                    worldManager.deleteWorld(withId: id)
                                    selectedWorldId = nil
                                }
                                showDeleteConfirmation = false
                            } label: {
                                ZStack {
                                    Image(isIPhoneSE ? "worldEditorLoadPopupButtonSE" : "worldEditorLoadPopupButton")
                                    
                                    Text("Delete")
                                        .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                        .foregroundColor(Color(hex: "f29412"))
                                }
                            }
                            
                            // Cancel button (right)
                            Button {
                                showDeleteConfirmation = false
                            } label: {
                                ZStack {
                                    Image(isIPhoneSE ? "worldEditorLoadPopupButtonSE" : "worldEditorLoadPopupButton")
                                    
                                    Text("Cancel")
                                        .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                        .foregroundColor(Color(hex: "f29412"))
                                }
                            }
                        }
                        .offset(y: isIPhoneSE ? 110 : 120)
                    }
                }
                .ignoresSafeArea(.keyboard)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Add this extension for hex color support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    WorldEditorLoadIPhone()
}

