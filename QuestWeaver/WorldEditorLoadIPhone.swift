//
//  WorldEditorLoadScreenIPhone.swift
//  QuestWeaver
//
//  Created by Roger Barron on 23/2/2025.
//

import SwiftUI

struct WorldEditorLoadIPhone: View {
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
                .offset(y: isIPhonePro ? -20 : 0) // Adjust for notch on Pro models
            
            // Load button on the right
            HStack {
                Spacer() // Pushes button to right
                Image(isIPhoneSE ? "worldEditorLoadButtonSE" : "worldEditorLoadButton")
                    .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                    .offset(x: -25) // Offset from right edge
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WorldEditorLoadIPhone()
}

