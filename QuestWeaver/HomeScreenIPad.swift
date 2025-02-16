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
        let width = screenSize.width
        let height = screenSize.height
        
        // Check both dimensions to handle both orientations
        if width >= 1366 || height >= 1366 {
            return "homescreenIpadPro"  // 12.9-inch iPad Pro
        }
        else if width >= 820 || height >= 820 {
            return "homescreenIpadAir"  // iPad Air and 11-inch iPad Pro
        }
        else {
            return "homescreenIpad"  // Smaller iPads
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

