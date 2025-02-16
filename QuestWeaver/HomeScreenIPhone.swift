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
                    // Background scroll
                    HStack {
                        Image("scrollMenu")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 3)
                        Spacer()
                    }
                    .ignoresSafeArea(.container, edges: [.top, .bottom])
                    
                    // Play button in front
                    HStack {
                        Image("playButton")
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .ignoresSafeArea(.container, edges: [.top, .bottom])
                }
            }
        }
    }
}

#Preview {
    HomeScreenIPhone()
}
