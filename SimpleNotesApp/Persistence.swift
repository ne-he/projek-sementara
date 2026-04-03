import Foundation

private let savedNotesKey = "savedNotes"

func saveToUserDefaults(notes: [Note]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(notes) {
        UserDefaults.standard.set(encoded, forKey: savedNotesKey)
    }
}

func loadFromUserDefaults() -> [Note]? {
    guard let data = UserDefaults.standard.data(forKey: savedNotesKey) else { return nil }
    let decoder = JSONDecoder()
    return try? decoder.decode([Note].self, from: data)
}
