//
//  DeleteWorldPopup.swift
//  QuestWeaver
//
//  Created by Roger Barron on 15/3/2025.
//

import SwiftUI

struct DeleteWorldPopup: View {
    @Binding var isPresented: Bool
    @Binding var selectedWorldName: String?
    @Binding var selectedWorldId: UUID?
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
                    Image("deleteWorldPopupSE")
                        .resizable()
                        .scaledToFit()
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                } else if isIpadPro {
                    Image("deleteWorldPopupIpadPro")
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                } else if isIpadAir {
                    Image("deleteWorldPopupAir")
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                } else {
                    Image("deleteWorldPopup")
                        .resizable()
                        .scaledToFit()
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                }
                
                // World name text
                Text("\"\(selectedWorldName ?? "Unknown World")\"")
                    .font(.custom("Papyrus", size: isIpadPro ? 36 : isIpadAir ? 30 : isIPhoneSE ? 20 : 24))
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
                
                // Buttons
                HStack(spacing: isIpadPro ? 35 : isIpadAir ? 30 : isIPhoneSE ? 10 : 15) {
                    // Delete button
                    Button {
                        if let id = selectedWorldId {
                            worldManager.deleteWorld(withId: id)
                            selectedWorldId = nil
                        }
                        isPresented = false
                    } label: {
                        ZStack {
                            Image(isIPhoneSE ? "worldEditorLoadPopupButtonSE" : 
                                  isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButton")
                            
                            Text("Delete")
                                .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                    
                    // Cancel button
                    Button {
                        isPresented = false
                    } label: {
                        ZStack {
                            Image(isIPhoneSE ? "worldEditorLoadPopupButtonSE" : 
                                  isIpadPro ? "worldEditorLoadPopupButtonIpadPro" : 
                                  isIpadAir ? "worldEditorLoadPopupButtonAir" : "worldEditorLoadPopupButton")
                            
                            Text("Cancel")
                                .font(.custom("Papyrus", size: isIPhoneSE ? 20 : 24))
                                .foregroundColor(Color(hex: "f29412"))
                        }
                    }
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/2 + (isIpadPro ? 180 : isIpadAir ? 160 : isIPhoneSE ? 110 : 120))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

