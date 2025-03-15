//
//  CreateWorldPopup.swift
//  QuestWeaver
//
//  Created by Roger Barron on 15/3/2025.
//

import SwiftUI

struct CreateWorldPopup: View {
    @Binding var isPresented: Bool
    @Binding var worldName: String
    @FocusState private var isFocused: Bool
    @State private var showDuplicateAlert = false
    @ObservedObject var worldManager: WorldEditorManager
    let isIPhoneSE: Bool
    let isIpadPro: Bool
    let isIpadAir: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            ZStack {
                // Background image based on device type
                if isIPhoneSE {
                    Image("createWorldPopupSE")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 455)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                } else if isIpadPro {
                    Image("createWorldPopupIpadPro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 683)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                } else if isIpadAir {
                    Image("createWorldPopupAir")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 683)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                } else {
                    Image("createWorldPopup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 683)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                }
                
                // Text input field
                ZStack(alignment: .leading) {
                    if !isFocused && worldName.isEmpty {
                        Text("Name Your World")
                            .font(.custom("Papyrus", size: isIpadPro ? 36 : isIpadAir ? 30 : isIPhoneSE ? 20 : 28))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    TextField("", text: $worldName)
                        .font(.custom("Papyrus", size: isIpadPro ? 36 : isIpadAir ? 30 : isIPhoneSE ? 20 : 28))
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
                .position(
                    x: geometry.size.width/2 + (isIpadPro ? 445 : isIpadAir ? 355 : isIPhoneSE ? 200 : 285),
                    y: geometry.size.height/2 + (isIpadPro ? -47 : isIpadAir ? -47 : isIPhoneSE ? -26 : -26)
                )
                
                // Buttons
                HStack(spacing: isIpadPro ? 35 : isIpadAir ? 30 : isIPhoneSE ? -50 : -40) {
                    // Create button
                    Button {
                        if worldManager.worldNameExists(worldName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                            showDuplicateAlert = true
                        } else {
                            let newWorld = WorldEditorData(name: worldName.trimmingCharacters(in: .whitespacesAndNewlines))
                            worldManager.saveWorld(newWorld)
                            worldName = ""
                            isPresented = false
                        }
                    } label: {
                        ZStack {
                            Image(isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButton")
                            
                            Text("Create")
                                .font(.custom("Papyrus", size: isIpadPro ? 24 : isIpadAir ? 24 : isIPhoneSE ? 20 : 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                    .disabled(worldName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    
                    // Cancel button
                    Button {
                        worldName = ""
                        isPresented = false
                    } label: {
                        ZStack {
                            Image(isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButton")
                            
                            Text("Cancel")
                                .font(.custom("Papyrus", size: isIpadPro ? 24 : isIpadAir ? 24 : isIPhoneSE ? 20 : 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                }
                .position(
                    x: geometry.size.width/2,
                    y: geometry.size.height/2 + (isIpadPro ? 180 : isIpadAir ? 180 : isIPhoneSE ? 100 : 100)
                )
            }
        }
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea(.all)
        .alert("World Already Exists", isPresented: $showDuplicateAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("A world with this name already exists. Please choose a different name.")
        }
    }
}

