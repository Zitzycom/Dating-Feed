import SwiftUI
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var selectedTab: String = "Online"
    @Published private(set) var profiles: [Profile] = []

    let tabs = ["Online", "Popular", "New", "Following"]

    private var cancellables = Set<AnyCancellable>()
    private let rc: RemoteConfigManager

    init(rc: RemoteConfigManager) {
        self.rc = rc

        rc.$profiles
            .receive(on: DispatchQueue.main)
            .assign(to: &$profiles)
    }

    var filteredProfiles: [Profile] {
        switch selectedTab {
        case "Online":
            return profiles.filter { $0.status == .online }
        default:
            return profiles
        }
    }

    func selectTab(_ tab: String) {
        selectedTab = tab
    }

    func fetchRemoteConfig() {
        rc.fetchRemoteConfig()
    }
}
