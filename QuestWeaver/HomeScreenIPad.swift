//
//  HomeScreenIPad.swift
//  QuestWeaver
//
//  Created by Roger Barron on 27/1/2025.
//

import SwiftUI

struct HomeScreenIPad: View {
    @State private var showWorldEditor = false
    
    private var imageToUse: String {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        
        if width >= 1366 {
            return "homescreenIpadPro"  // 12.9-inch iPad Pro
        }
        else if width >= 1180 {
            return "homescreenIpadAir"  // iPad Air and 11-inch iPad Pro
        }
        else {
            return "homescreenIpad"  // Standard iPads (10.2")
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
            
            Image(imageToUse)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack(spacing: 100) {
                    // Editor button on the left
                    Button {
                        showWorldEditor = true
                    } label: {
                        Image(isIpadPro ? "editorButtonIpadPro" : 
                              isIpadAir ? "editorButtonIpadAir" : "editorButtonIpad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 683/2)
                    }
                    
                    // Download button
                    Image(isIpadPro ? "downloadButtonIpadPro" : 
                          isIpadAir ? "downloadButtonIpadAir" : "downloadButtonIpad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 683/2)
                }
                .ignoresSafeArea()
                .padding(.bottom, isIpadPro ? 3 : isIpadAir ? -12 : 8)
            }
        }
        .fullScreenCover(isPresented: $showWorldEditor) {
            WorldEditorLoadIPad()
        }
    }
}

#Preview {
    HomeScreenIPad()
}

