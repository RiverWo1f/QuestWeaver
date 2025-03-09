//
//  Untitled.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

struct WorldEditorLoadIPad: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var worldManager = WorldEditorManager()
    @State private var showCreateWorldPopup = false
    @State private var worldName: String = ""
    @FocusState private var isFocused: Bool
    @State private var showDuplicateAlert = false
    @State private var selectedWorldId: UUID?
    @State private var showDeleteConfirmation = false
    @State private var selectedWorldName: String?
    @State private var showMaxWorldsAlert = false
    
    private var backgroundImage: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        
        if width >= 1366 {
            return "worldEditorLoadBackgroundIpadPro"  // 12.9" iPad Pro
        } else if width >= 1180 {
            return "worldEditorLoadBackgroundAir"      // iPad Air & 11" iPad Pro
        } else {
            return "worldEditorLoadBackgroundIpad"     // Smaller iPads
        }
    }
    
    private var backButtonImage: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        
        if width >= 1366 {
            return "backButtonIpadPro"
        }
        else if width >= 1180 {
            return "backButtonAir"
        }
        else {
            return "backButtonIpad"
        }
    }
    
    private var backButtonOffset: (CGFloat, CGFloat) {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        
        if width >= 1366 {
            return (80, 15)  // 12.9" iPad Pro
        }
        else if width >= 1180 {
            return (60, 10)  // iPad Air & 11" iPad Pro
        }
        else {
            return (51, 10)  // Changed from 40 to 20 to move it up for gen 8
        }
    }
    
    private var loadButtonImage: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        
        print("Screen width for load button: \(width)")  // Debug print
        
        if width >= 1366 {
            return "worldEditorLoadButtonIpadPro"
        }
        else if width >= 1180 {
            return "worldEditorLoadButtonAir"
        }
        else {
            return "worldEditorLoadButtonIpad"
        }
    }
    
    private var isIpadAir: Bool {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width >= 1180 && screenSize.width < 1366
    }
    
    private var isIpadPro: Bool {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width >= 1366
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                
            Image(backgroundImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .ignoresSafeArea()
                .ignoresSafeArea(.keyboard)
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(backButtonImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    }
                    .offset(x: backButtonOffset.0, y: backButtonOffset.1)
                    Spacer()
                }
                Spacer()
                
                // Load buttons at the bottom
                HStack(spacing: isIpadPro ? 70 : isIpadAir ? 50 : 30) {
                    // Create World button
                    Button {
                        if worldManager.worlds.count >= 4 {
                            showMaxWorldsAlert = true
                        } else {
                            showCreateWorldPopup = true
                        }
                    } label: {
                        ZStack {
                            Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                            Text("Create World")
                                .font(.custom("Papyrus", size: 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                    .alert("Maximum Worlds Reached", isPresented: $showMaxWorldsAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Maximum limit of 4 worlds reached. Please delete a world before creating a new one.")
                    }
                    
                    // Load World button
                    Button {
                        // Load action
                    } label: {
                        ZStack {
                            Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                            Text("Load World")
                                .font(.custom("Papyrus", size: 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                    
                    // Delete World button
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
                            Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                            Text("Delete World")
                                .font(.custom("Papyrus", size: 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                }
                .ignoresSafeArea()
                .padding(.bottom, isIpadPro ? 70 : isIpadAir ? 50 : 90)
            }
            .ignoresSafeArea(.keyboard)
            
            // Right side with world list
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(worldManager.worlds.enumerated()), id: \.element.id) { index, world in
                        ZStack {
                            Image(isIpadPro ? "loadWorldBoxIpadPro" : 
                                  isIpadAir ? "loadWorldBoxAir" : "loadWorldBoxIpad")
                                .opacity(selectedWorldId == world.id ? 1 : 0)
                            
                            Text(world.name)
                                .font(.custom("Papyrus", size: 22))
                                .foregroundColor(.white)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedWorldId = world.id
                        }
                        .frame(height: isIpadPro ? 90 : isIpadAir ? 90 : 100)
                    }
                }
                .padding(.horizontal, 20)
                .frame(width: isIpadPro ? 380 : isIpadAir ? 380 : 400)
            }
            .frame(height: isIpadPro ? 380 : isIpadAir ? 380 : 420)
            .offset(x: isIpadPro ? -308 : isIpadAir ? -308 : -291, y: -20)

            // Popup overlay
            if showCreateWorldPopup {
                GeometryReader { geometry in
                    Color.black.opacity(0.5)
                        .ignoresSafeArea(edges: .all)
                    
                    ZStack {
                        Image(isIpadPro ? "createWorldPopupIpadPro" : 
                              isIpadAir ? "createWorldPopupAir" : "createWorldPopupIpad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: isIpadPro ? 683 : 683)
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        
                        // Text input field
                        ZStack(alignment: .leading) {
                            if !isFocused && worldName.isEmpty {
                                Text("Name Your World")
                                    .font(.custom("Papyrus", size: isIpadPro ? 36 : isIpadAir ? 30 : 28))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            TextField("", text: $worldName)
                                .font(.custom("Papyrus", size: isIpadPro ? 36 : isIpadAir ? 30 : 28))
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
                                .onSubmit {
                                    // Dismiss the keyboard when return is pressed
                                    isFocused = false
                                }
                        }
                        .position(x: geometry.size.width/2 + (isIpadPro ? 445 : isIpadAir ? 355 : 305), y: geometry.size.height/2 - 47)
                        
                        // Popup Buttons
                        HStack(spacing: isIpadPro ? 35 : isIpadAir ? 30 : 25) {
                            // Create button (left)
                            Button {
                                // Check if the world name already exists
                                if worldManager.worldNameExists(worldName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                    showDuplicateAlert = true
                                } else {
                                    // Create a new world and save it
                                    let newWorld = WorldEditorData(name: worldName.trimmingCharacters(in: .whitespacesAndNewlines))
                                    worldManager.saveWorld(newWorld)
                                    worldName = "" // Clear the text field
                                    showCreateWorldPopup = false // Dismiss the popup
                                }
                            } label: {
                                ZStack {
                                    Image(isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                          isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButtonIpad")
                                    
                                    Text("Create")
                                        .font(.custom("Papyrus", size: 24))
                                        .foregroundColor(Color(hex: "f29412"))
                                }
                            }
                            
                            // Cancel button (right)
                            Button {
                                worldName = "" // Clear the text field
                                showCreateWorldPopup = false // Dismiss the popup
                            } label: {
                                ZStack {
                                    Image(isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                          isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButtonIpad")
                                    
                                    Text("Cancel")
                                        .font(.custom("Papyrus", size: 24))
                                        .foregroundColor(Color(hex: "f29412"))
                                }
                            }
                        }
                        .position(x: geometry.size.width/2, y: geometry.size.height/2 + 180)
                    }
                }
                .ignoresSafeArea(.keyboard)
            }

            // Delete confirmation popup
            if showDeleteConfirmation {
                GeometryReader { geometry in
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    ZStack {
                        Image(isIpadPro ? "deleteWorldPopupIpadPro" : 
                              isIpadAir ? "deleteWorldPopupAir" : "deleteWorldPopupIpad")
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        
                        // Display only the name of the world to be deleted in black
                        Text("\"\(selectedWorldName ?? "Unknown World")\"")
                            .font(.custom("Papyrus", size: isIpadPro ? 36 : isIpadAir ? 30 : 28))
                            .foregroundColor(.black)
                            .padding(.bottom, 20)
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        
                        // Popup Buttons
                        HStack(spacing: isIpadPro ? 35 : isIpadAir ? 30 : 25) {
                            // Delete button (left)
                            Button {
                                if let id = selectedWorldId {
                                    worldManager.deleteWorld(withId: id)
                                    selectedWorldId = nil
                                }
                                showDeleteConfirmation = false
                            } label: {
                                ZStack {
                                    Image(isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                          isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButtonIpad")
                                    
                                    Text("Delete")
                                        .font(.custom("Papyrus", size: 24))
                                        .foregroundColor(Color(hex: "f29412"))
                                }
                            }
                            
                            // Cancel button (right)
                            Button {
                                showDeleteConfirmation = false
                            } label: {
                                ZStack {
                                    Image(isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                          isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButtonIpad")
                                    
                                    Text("Cancel")
                                        .font(.custom("Papyrus", size: 24))
                                        .foregroundColor(Color(hex: "f29412"))
                                }
                            }
                        }
                        .offset(y: isIpadPro ? 180 : 160)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                    }
                }
                .ignoresSafeArea(.keyboard)
            }
        }
        .onAppear {
            // Lock to landscape
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
            }
            AppDelegate.orientationLock = .landscape
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    WorldEditorLoadIPad()
}



