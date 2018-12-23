import Foundation

struct Message: Codable {
    let id: Int
    let body: String
    let title: String
    let userId: Int
}
