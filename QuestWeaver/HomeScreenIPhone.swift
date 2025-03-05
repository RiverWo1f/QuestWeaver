//
//  HomeScreenIPhone.swift
//  QuestWeaver
//
//  Created by Roger Barron on 27/1/2025.
//

import SwiftUI

struct HomeScreenIPhone: View {
    @State private var showWorldEditor = false
    @State private var showPlay = false
    @State private var showSetup = false
    @State private var showEditor = false
    @State private var showDownload = false
    
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
                                .frame(width: isIPhoneSE ? 555/2 : 833/3)
                                .offset(x: isIPhoneSE ? -10 : 24, y: isIPhoneSE ? 0 : 0)
                            Spacer()
                        }
                        .ignoresSafeArea(.container, edges: [.top, .bottom])
                        
                        // Play button
                        HStack {
                            ZStack {
                                Image(isIPhoneSE ? "playButtonSE" : "playButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                    .contentShape(Rectangle())
                                
                                NavigationLink(destination: PlayGame()) {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                }
                            }
                            .offset(x: isIPhoneSE ? 15 : 72, y: isIPhoneSE ? -120 : -120)
                            Spacer()
                        }
                        .ignoresSafeArea()
                        
                        // Setup button
                        HStack {
                            ZStack {
                                Image(isIPhoneSE ? "setupButtonSE" : "setupButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                    .contentShape(Rectangle())
                                
                                NavigationLink(destination: SetupGame()) {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                }
                            }
                            .offset(x: isIPhoneSE ? 15 : 72, y: isIPhoneSE ? -40 : -37)
                            Spacer()
                        }
                        .ignoresSafeArea()
                        
                        // Editor button
                        HStack {
                            ZStack {
                                Button {
                                    showWorldEditor = true
                                } label: {
                                    Image(isIPhoneSE ? "editorButtonSE" : "editorButton")
                                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                }
                            }
                            .offset(x: isIPhoneSE ? 15 : 72, y: isIPhoneSE ? 40 : 47)
                            Spacer()
                        }
                        .ignoresSafeArea()
                        
                        // Download button
                        HStack {
                            ZStack {
                                Image(isIPhoneSE ? "downloadButtonSE" : "downloadButton")
                                    .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                    .contentShape(Rectangle())
                                
                                NavigationLink(destination: Text("Download Screen")) {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: isIPhoneSE ? 455/2 : 683/3, height: isIPhoneSE ? 147/2 : 220/3)
                                }
                            }
                            .offset(x: isIPhoneSE ? 15 : 72, y: isIPhoneSE ? 120 : 132)
                            Spacer()
                        }
                        .ignoresSafeArea()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showWorldEditor) {
            WorldEditorLoadIPhone()
        }
    }
}

#Preview {
    HomeScreenIPhone()
}
