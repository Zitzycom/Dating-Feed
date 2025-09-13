import SwiftUI
import FirebaseCore

@main
struct DatingFeedApp: App {
    @StateObject private var rcManager: RemoteConfigManager
    @State private var showSubscriptionModal: Bool = true
    
    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        _rcManager = StateObject(wrappedValue: RemoteConfigManager())
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    MainTabView()
                        .environmentObject(rcManager)
                }
                
                if showSubscriptionModal {
                    SubscriptionModalView(isPresented: $showSubscriptionModal)
                        .zIndex(1)
                        .transition(.opacity)
                        .animation(.easeInOut, value: showSubscriptionModal)
                }
            }
            .preferredColorScheme(.light)
        }
    }
}
