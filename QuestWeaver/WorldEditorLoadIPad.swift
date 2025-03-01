//
//  Untitled.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

struct WorldEditorLoadIPad: View {
    @Environment(\.dismiss) private var dismiss
    
    private var imageToUse: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        let height = screenSize.height
        
        // Check both dimensions to handle both orientations
        if width >= 1366 || height >= 1366 {
            return "worldEditorLoadBackgroundIpad"  // 12.9-inch iPad Pro
        }
        else if width >= 820 || height >= 820 {
            return "worldEditorLoadBackgroundAir"  // iPad Air and 11-inch iPad Pro
        }
        else {
            return "worldEditorLoadBackgroundIpad"  // Smaller iPads
        }
    }
    
    private var isIpadAir: Bool {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width >= 820 || screenSize.height >= 820
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Image(imageToUse)
                .edgesIgnoringSafeArea(.all)
            
            // Back button
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(isIpadAir ? "backButtonAir" : "backButtonIpad")
                    }
                    .padding(.leading, 50)
                    .padding(.top, 40)
                    Spacer()
                }
                Spacer()
            }
            
            // Main buttons
            VStack {
                Spacer()
                HStack(spacing: 50) {
                    // Create World button
                    ZStack {
                        Image(isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                        Text("Create World")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                    
                    // Load World button
                    ZStack {
                        Image(isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                        Text("Load World")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                    
                    // Delete World button
                    ZStack {
                        Image(isIpadAir ? "worldEditorLoadButtonAir" : "worldEditorLoadButtonIpad")
                        Text("Delete World")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(Color(hex: "f29412"))
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 80)
                .padding(.leading, 90)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct WorldEditorLoadIPad_Previews: PreviewProvider {
    static var previews: some View {
        WorldEditorLoadIPad()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewDisplayName("iPad Air")
    }
}

