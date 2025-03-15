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
                        if worldManager.worlds.count >= 10 {
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
                        Text("Maximum limit of 10 worlds reached. Please delete a world before creating a new one.")
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
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: isIpadPro ? 25 : isIpadAir ? 15 : 0) {
                        ForEach(Array(worldManager.worlds.enumerated()), id: \.element.id) { index, world in
                            ZStack {
                                Image(isIpadPro ? "loadWorldBoxIpadPro" : 
                                      isIpadAir ? "loadWorldBoxAir" : "loadWorldBoxIpad")
                                    .opacity(selectedWorldId == world.id ? 1 : 0)
                                
                                Text(world.name)
                                    .font(.custom("Papyrus", size: isIpadPro ? 32 : isIpadAir ? 26 : 24))
                                    .foregroundColor(.white)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedWorldId = world.id
                                withAnimation {
                                    scrollProxy.scrollTo(world.id, anchor: .center)
                                }
                            }
                            .frame(height: isIpadPro ? 150 : isIpadAir ? 90 : 110)
                            .id(world.id)
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(width: isIpadPro ? 500 : isIpadAir ? 380 : 400)
                }
                .simultaneousGesture(DragGesture().onChanged { _ in
                    selectedWorldId = nil
                })
                .frame(height: isIpadPro ? 530 : isIpadAir ? 380 : 400)
                .offset(x: isIpadPro ? -365 : isIpadAir ? -308 : -291, 
                       y: isIpadPro ? -30 : isIpadAir ? -10 : -35)
            }

            // Popup overlay
            if showCreateWorldPopup {
                CreateWorldPopup(
                    isPresented: $showCreateWorldPopup,
                    worldName: $worldName,
                    worldManager: worldManager,
                    isIPhoneSE: false,
                    isIpadPro: isIpadPro,
                    isIpadAir: isIpadAir
                )
            }

            // Delete confirmation popup
            if showDeleteConfirmation {
                DeleteWorldPopup(
                    isPresented: $showDeleteConfirmation,
                    selectedWorldName: $selectedWorldName,
                    selectedWorldId: $selectedWorldId,
                    worldManager: worldManager,
                    isIPhoneSE: false,
                    isIpadPro: isIpadPro,
                    isIpadAir: isIpadAir
                )
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
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    WorldEditorLoadIPad()
}



