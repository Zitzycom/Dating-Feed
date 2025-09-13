import FirebaseRemoteConfig
import FirebaseCore
import Combine

@MainActor
final class RemoteConfigManager: ObservableObject {
    @Published var profiles: [Profile] = []
    private let remoteConfig: RemoteConfig

    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        self.remoteConfig.configSettings = settings
    }

    func setupDefaults() {
        remoteConfig.setDefaults(["feed_data": "[]" as NSObject])

        if let url = Bundle.main.url(forResource: "feed_default", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let str = String(data: data, encoding: .utf8) {
            self.parseFeedJSON(str)
        }
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetchAndActivate { [weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                print("RemoteConfig fetch error:", error)
                return
            }

            Task { @MainActor [weak self] in
                guard let self = self else { return }
                let jsonString = self.remoteConfig.configValue(forKey: "feed_data").stringValue
                self.parseFeedJSON(jsonString)
            }
        }
    }

    private func parseFeedJSON(_ json: String) {
        guard let data = json.data(using: .utf8) else { return }
        do {
            let decoded = try JSONDecoder().decode([Profile].self, from: data)
            self.profiles = decoded
        } catch {
            print("JSON parse error:", error)
        }
    }
}
