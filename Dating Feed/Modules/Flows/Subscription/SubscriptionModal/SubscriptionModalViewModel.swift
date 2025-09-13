import Foundation

final class SubscriptionModalViewModel: ObservableObject {
    @Published var currentIndex: Int = 0

    let slides: [SubscriptionSlide] = [
        SubscriptionSlide(title: "Get 599 Coins NOW And\nEvery Week", highlight: "599 Coins", imageName: "payScreenMan1"),
        SubscriptionSlide(title: "Send Unlimited Messages", highlight: "Unlimited Messages", imageName: "payScreenMan2"),
        SubscriptionSlide(title: "Turn Off Camera & Sound ", highlight: "Turn Off", imageName: "payScreenMan3"),
        SubscriptionSlide(title: "Mark Your Profile With \nVIP Status", highlight: "VIP Status", imageName: "payScreenMan4")
    ]

    func closeModal(completion: @escaping () -> Void) {
        completion()
    }

    func restoreTapped() { }
    func subscribeTapped() { }
    func termsTapped() { }
    func privacyTapped() { }
}
