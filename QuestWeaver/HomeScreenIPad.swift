//
//  HomeScreenIPad.swift
//  QuestWeaver
//
//  Created by Roger Barron on 27/1/2025.
//

import SwiftUI

struct HomeScreenIPad: View {
    private var imageToUse: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        let height = screenSize.height
        
        // Check both dimensions to handle both orientations
        if width >= 1366 || height >= 1366 {
            return "homescreenIpadPro"  // 12.9-inch iPad Pro
        }
        else if width >= 820 || height >= 820 {
            return "homescreenIpadAir"  // iPad Air and 11-inch iPad Pro
        }
        else {
            return "homescreenIpad"  // Smaller iPads
        }
    }
    
    private var isIpadAir: Bool {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width >= 820 || screenSize.height >= 820
    }
    
    var body: some View {
        ZStack {
            // Black background to cover any white lines
            Color.black
                .ignoresSafeArea()
            
            Image(imageToUse)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.black)
                .ignoresSafeArea()
                .offset(y: -1)
            
            VStack {
                Spacer()
                
                HStack(spacing: 100) { // Added spacing between buttons
                    // Editor button on the left
                    Image(isIpadAir ? "editorButtonIpadAir" : "editorButtonIpad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 683/2)
                    
                    // Download button
                    Image(isIpadAir ? "downloadButtonIpadAir" : "downloadButtonIpad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 683/2)
                }
                .ignoresSafeArea()
                .padding(.bottom, 8) // Adjust this value to move buttons up
            }
        }
    }
}

#Preview {
    HomeScreenIPad()
}

