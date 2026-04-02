import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    init() {
        loadSampleNotes()
    }

    func loadSampleNotes() {
        notes = [
            Note(title: "Catatan Pertama", content: "Ini adalah isi catatan pertama."),
            Note(title: "Ide Proyek", content: "Buat aplikasi catatan sederhana dengan SwiftUI.")
        ]
    }
}
