import GameKit

class GameCenterManager: NSObject, ObservableObject {
    @Published var isAuthenticated = false
    static let shared = GameCenterManager()
    
    override init() {
        super.init()
        authenticateUser()
    }
    
    func authenticateUser() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // Present the view controller if needed
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(viewController, animated: true)
                }
            } else if localPlayer.isAuthenticated {
                self.isAuthenticated = true
                print("Successfully authenticated to Game Center")
            } else {
                self.isAuthenticated = false
                print("Failed to authenticate to Game Center")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Add achievement
    func reportAchievement(identifier: String, percentComplete: Double) {
        let achievement = GKAchievement(identifier: identifier)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = true
        
        GKAchievement.report([achievement]) { error in
            if let error = error {
                print("Error reporting achievement: \(error.localizedDescription)")
            }
        }
    }
    
    // Add score to leaderboard
    func reportScore(score: Int, leaderboardID: String) {
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardID)
        scoreReporter.value = Int64(score)
        
        GKScore.report([scoreReporter]) { error in
            if let error = error {
                print("Error reporting score: \(error.localizedDescription)")
            }
        }
    }
} 