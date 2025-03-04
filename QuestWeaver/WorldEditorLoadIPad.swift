//
//  Untitled.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

struct WorldEditorLoadIPad: View {
    @Environment(\.dismiss) private var dismiss
    
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
                    ZStack {
                        Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                              isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                        Text("Create World")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                    
                    ZStack {
                        Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                              isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                        Text("Load World")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                    
                    ZStack {
                        Image(isIpadPro ? "worldEditorLoadButtonIpadPro" : 
                              isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                        Text("Delete World")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                }
                .ignoresSafeArea()
                .padding(.bottom, isIpadPro ? 70 : isIpadAir ? 50 : 90)
            }
        }
        .onAppear {
            // Lock to landscape
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
            }
            AppDelegate.orientationLock = .landscape
        }
    }
}

#Preview {
    WorldEditorLoadIPad()
}



