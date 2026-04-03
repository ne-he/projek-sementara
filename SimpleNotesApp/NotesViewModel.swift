import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = [] {
        didSet {
            saveNotes()
        }
    }

    init() {
        if let saved = loadFromUserDefaults() {
            notes = saved
        }
        // loadSampleNotes sudah tidak digunakan; data diambil dari UserDefaults
    }

    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }

    func saveNotes() {
        saveToUserDefaults(notes: notes)
    }

    @available(*, deprecated, message: "Gunakan UserDefaults. Fungsi ini tidak lagi digunakan.")
    func loadSampleNotes() {
        notes = [
            Note(title: "Catatan Pertama", content: "Ini adalah isi catatan pertama."),
            Note(title: "Ide Proyek", content: "Buat aplikasi catatan sederhana dengan SwiftUI.")
        ]
    }
}
