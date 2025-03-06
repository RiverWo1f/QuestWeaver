//
//  Untitled.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

struct WorldEditorLoadIPad: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showCreateWorldPopup = false
    @State private var worldName: String = ""
    @FocusState private var isFocused: Bool
    
    private var backgroundImage: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        
        if width >= 1366 {
            return "worldEditorLoadBackgroundIpadPro"  // 12.9" iPad Pro
        }
        else if width >= 1180 {
            return "worldEditorLoadBackgroundAir"      // iPad Air & 11" iPad Pro
        }
        else if width >= 1080 {
            return "worldEditorLoadBackgroundIpad"     // iPad 8th gen (10.2")
        }
        else {
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
            return (51, 40)  // Changed from 53 to 51 for 8th gen
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
                        showCreateWorldPopup = true
                    } label: {
                        ZStack {
                            Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                            Text("Create World")
                                .font(.custom("Papyrus", size: 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
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
                        // Delete action
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
                            if !isFocused {
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
                        }
                        .position(x: geometry.size.width/2 + (isIpadPro ? 445 : isIpadAir ? 355 : 305), y: geometry.size.height/2 - 47)
                        
                        // Popup Buttons
                        HStack(spacing: isIpadPro ? 35 : isIpadAir ? 30 : 25) {
                            // Create button (left)
                            Button {
                                // Confirm action
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
                                worldName = ""
                                showCreateWorldPopup = false
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



