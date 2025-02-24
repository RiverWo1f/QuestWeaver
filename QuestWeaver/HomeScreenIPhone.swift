//
//  HomeScreenIPhone.swift
//  QuestWeaver
//
//  Created by Roger Barron on 27/1/2025.
//

import SwiftUI

struct HomeScreenIPhone: View {
    @State private var showWorldEditor = false
    
    var body: some View {
        NavigationStack {
            let screenSize = UIScreen.main.bounds.size
            let isIPhoneSE = (screenSize.width <= 375 && screenSize.height <= 667) || (screenSize.width <= 667 && screenSize.height <= 375)
            
            // Background layer
            Group {
                if isIPhoneSE {
                    Image("homescreenSE")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .ignoresSafeArea()
                } else {
                    Image("homescreen")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .ignoresSafeArea()
                }
            }
            .overlay {
                GeometryReader { geometry in
                    ZStack {
                        // Background scroll - using native size
                        HStack {
                            Image("scrollMenu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: isIPhoneSE ? 555/2 : 833/3)  // Convert from pixels to points
                            Spacer()
                        }
                        .ignoresSafeArea(.container, edges: [.top, .bottom])
                        
                        // Play button in front - using native size
                        HStack {
                            Image(isIPhoneSE ? "playButtonSE" : "playButton")
                                .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                .offset(x: 25, y: -130)  // Adjusted spacing
                            Spacer()
                        }
                        .ignoresSafeArea(.container, edges: [.top, .bottom])
                        
                        // Setup button in front - using native size
                        HStack {
                            Image(isIPhoneSE ? "setupButtonSE" : "setupButton")
                                .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                .offset(x: 25, y: -42)  // Adjusted spacing
                            Spacer()
                        }
                        .ignoresSafeArea(.container, edges: [.top, .bottom])
                        
                        // Editor button
                        HStack {
                            NavigationLink(destination: WorldEditorLoadIPhone()) {
                                Image(isIPhoneSE ? "editorButtonSE" : "editorButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                    .offset(x: 50, y: 47)
                            }
                            Spacer()
                        }
                        .ignoresSafeArea()
                        
                        // Download button in front - using native size
                        HStack {
                            Image(isIPhoneSE ? "downloadButtonSE" : "downloadButton")
                                .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                .offset(x: 25, y: 140)  // Adjusted spacing
                            Spacer()
                        }
                        .ignoresSafeArea(.container, edges: [.top, .bottom])
                    }
                }
            }
        }
    }
}

#Preview {
    HomeScreenIPhone()
}
