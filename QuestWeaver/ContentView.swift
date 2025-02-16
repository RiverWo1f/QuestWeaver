import SwiftUI

struct ContentView: View {
    var body: some View {
        let deviceModel = UIDevice.current.userInterfaceIdiom
        
        ZStack {
            if deviceModel == .pad {
                HomeScreenIPad() // Load iPad layout
            } else {
                HomeScreenIPhone() // Load iPhone layout
            }
        }
    }
}

#Preview {
    ContentView()
}