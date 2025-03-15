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
                    .padding(.horizontal, isIPhoneSE ? 10 : 20)
                }
                .simultaneousGesture(DragGesture().onChanged { _ in
                    selectedWorldId = nil
                })
                .frame(width: isIPhoneSE ? 160 : 280, height: isIPhoneSE ? 225 : 225)
                .offset(x: isIPhoneSE ? -52 : -45, y: isIPhoneSE ? 27 : 48)
            }
            
            // Popup overlay
            if showCreateWorldPopup {
                CreateWorldPopup(
                    isPresented: $showCreateWorldPopup,
                    worldName: $worldName,
                    worldManager: worldManager,
                    isIPhoneSE: isIPhoneSE,
                    isIpadPro: false,
                    isIpadAir: false
                )
            }
            
            // Delete confirmation popup
            if showDeleteConfirmation {
                DeleteWorldPopup(
                    isPresented: $showDeleteConfirmation,
                    selectedWorldName: $selectedWorldName,
                    selectedWorldId: $selectedWorldId,
                    worldManager: worldManager,
                    isIPhoneSE: isIPhoneSE,
                    isIpadPro: false,
                    isIpadAir: false
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WorldEditorLoadIPhone()
}

