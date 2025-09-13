import Foundation

struct PreviewMocks {
    static let profile = Profile(
        id: UUID(),
        name: "Name",
        age: 99,
        countryCode: "RU",
        images: [URL(string: "https://sobakovod.club/uploads/posts/2021-12/1639675058_1-sobakovod-club-p-sobaki-sobaka-s-bolshoi-zhopoi-1.jpg")!],
        status: .online
    )
}
