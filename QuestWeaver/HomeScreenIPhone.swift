//
//  HomeScreenIPhone.swift
//  QuestWeaver
//
//  Created by Roger Barron on 27/1/2025.
//

import SwiftUI

struct HomeScreenIPhone: View {
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let isIPhoneSE = (screenSize.width <= 375 && screenSize.height <= 667) || (screenSize.width <= 667 && screenSize.height <= 375)
        
        Group {
            if isIPhoneSE {
                // SE version
                Image("homescreenSE")
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
    HomeScreenIPhone()
}

