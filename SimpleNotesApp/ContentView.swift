import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNote = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NoteRow(note: note)
                }
                .onDelete { offsets in
                    viewModel.deleteNotes(at: offsets)
                }
            }
            .navigationTitle("Catatan Saya")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddNote = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView { title, content in
                    addNote(title: title, content: content)
                }
            }
        }
    }

    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        viewModel.notes.append(newNote)
    }
}

struct NoteRow: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.headline)
            Text(note.createdAt, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
