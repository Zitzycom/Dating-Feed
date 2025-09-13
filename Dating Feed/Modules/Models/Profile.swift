import Foundation

struct Profile: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let age: Int
    let countryCode: String?
    let images: [URL]?
    let status: Status?

    enum Status: String, Codable {
        case online, offline, recently
    }
}
