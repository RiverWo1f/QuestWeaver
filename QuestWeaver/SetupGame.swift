//
//  SetupGame.swift
//  QuestWeaver
//
//  Created by Roger Barron on 25/2/2025.
//

import SwiftUI

struct SetupGame: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image("testImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            Text("Setup Game Screen")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .onAppear {
            // Force landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }
    }
}

struct SetupGame_Previews: PreviewProvider {
    static var previews: some View {
        SetupGame()
    }
}

