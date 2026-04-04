import Foundation

enum NoteCategory: String, Codable, CaseIterable {
    case pribadi = "Pribadi"
    case pekerjaan = "Pekerjaan"
    case lainnya = "Lainnya"

    var icon: String {
        switch self {
        case .pribadi: return "person.fill"
        case .pekerjaan: return "briefcase.fill"
        case .lainnya: return "tag.fill"
        }
    }

    var color: String {
        switch self {
        case .pribadi: return "blue"
        case .pekerjaan: return "orange"
        case .lainnya: return "green"
        }
    }
}

struct Note: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var category: NoteCategory = .lainnya
}
