//
//  WorldEditorLoadScreenIPhone.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

struct WorldEditorLoadIPhone: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let isIPhoneSE = (screenSize.width <= 375 && screenSize.height <= 667) || (screenSize.width <= 667 && screenSize.height <= 375)
        let isIPhonePro = screenSize.height >= 844 // For iPhone Pro models
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image(isIPhoneSE ? "worldEditorLoadBackgroundSE" : "worldEditorLoadBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(y: isIPhonePro ? -20 : 0)
            
            // Back button with navigation
            HStack {
                ZStack {
                    Image(isIPhoneSE ? "backButtonIphoneSE" : "backButtonIphone")
                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                    }
                }
                .offset(x: isIPhoneSE ? -29 : -29, y: -155)
                Spacer()
            }
            .ignoresSafeArea()
            
            // VStack for other buttons
            VStack(spacing: 20) {
                // Top button
                HStack {
                    Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                        .offset(x: isIPhoneSE ? -9 : 40)
                    Spacer()
                }
                
                // Middle button
                HStack {
                    Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                        .offset(x: isIPhoneSE ? -9 : 40)
                    Spacer()
                }
                
                // Bottom button
                HStack {
                    Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                        .offset(x: isIPhoneSE ? -9 : 40)
                    Spacer()
                }
            }
            .offset(y: 20)
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)  // Hide the default back button
    }
}

#Preview {
    WorldEditorLoadIPhone()
}

