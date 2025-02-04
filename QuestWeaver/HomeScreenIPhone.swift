//
//  HomeScreen.swift
//  QuestWeaver
//
//  Created by Roger Barron on 27/1/2025.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        let deviceModel = UIDevice.current.userInterfaceIdiom
        let isIPhoneSE = deviceModel == .phone && UIScreen.main.bounds.width <= 375
        let isIpad = deviceModel == .pad
        let isIpadAir = isIpad && UIScreen.main.bounds.height == 1024 // Adjust height as needed for iPad Air
        
        Group {
            if isIPhoneSE {
                // SE version
                Image("homescreenSE")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else if isIpadAir {
                // iPad Air version
                Image("homescreenIpadAir")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else if isIpad {
                // iPad version
                Image("homescreenIpad")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                // Standard iPhone version
                Image("homescreen")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    HomeScreen()
}

