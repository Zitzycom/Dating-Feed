import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var rcManager: RemoteConfigManager

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.main
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = .main
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes

        appearance.stackedLayoutAppearance.selected.iconColor = .main
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = normalAttributes

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            NavigationView { FeedView(rc: rcManager) }
                .tabItem {
                    Image(.tabFeed)
                    Text("Feed")
                }

            Text("Live")
                .tabItem {
                    Image(.tabLife)
                    Text("Live")
                }

            Text("Chat")
                .tabItem {
                    Image(.tabChat)
                    Text("Chat")
                }

            Text("Profile")
                .tabItem {
                    Image(.tabProfile)
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(RemoteConfigManager())
}
