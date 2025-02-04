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
        
        if (screenSize.width == 1024 && screenSize.height == 1366) ||
           (screenSize.width == 1366 && screenSize.height == 1024) {
            return "homescreenIpadPro"
        }
        else if (screenSize.width == 820 && screenSize.height == 1180) ||
                (screenSize.width == 1180 && screenSize.height == 820) {
            return "homescreenIpadAir"
        }
        else {
            return "homescreenIpad"
        }
    }
    
    var body: some View {
        Image(imageToUse)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}

#Preview {
    HomeScreenIPad()
}

