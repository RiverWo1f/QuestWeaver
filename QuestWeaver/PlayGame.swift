//
//  PlayGame.swift
//  QuestWeaver
//
//  Created by Roger Barron on 25/2/2025.
//

import SwiftUI

struct PlayGame: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image("testImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            Text("Play Game Screen")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .onAppear {
            // Force landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }
    }
}

struct PlayGame_Previews: PreviewProvider {
    static var previews: some View {
        PlayGame()
    }
}

