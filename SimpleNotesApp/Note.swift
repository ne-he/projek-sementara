import Foundation

struct Note: Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var createdAt: Date = Date()
}
