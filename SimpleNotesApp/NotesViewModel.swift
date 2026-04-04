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
    }

    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }

    func deleteAllNotes() {
        notes.removeAll()
    }

    func updateNote(id: UUID, title: String, content: String, category: NoteCategory) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].title = title
            notes[index].content = content
            notes[index].category = category
            notes[index].updatedAt = Date()
        }
    }

    func addNote(title: String, content: String, category: NoteCategory) {
        let newNote = Note(title: title, content: content, category: category)
        notes.append(newNote)
    }

    func saveNotes() {
        saveToUserDefaults(notes: notes)
    }
}
