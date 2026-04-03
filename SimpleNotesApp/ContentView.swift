import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNote = false
    @State private var deleteOffsets: IndexSet?
    @State private var showDeleteAlert = false
    @State private var selectedNote: Note?
    @State private var showingEditNote = false
    @State private var searchText = ""

    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return viewModel.notes
        }
        return viewModel.notes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredNotes) { note in
                    NoteRow(note: note)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedNote = note
                            showingEditNote = true
                        }
                }
                .onDelete { offsets in
                    deleteOffsets = offsets
                    showDeleteAlert = true
                }
            }
            .navigationTitle("Catatan Saya")
            .searchable(text: $searchText, prompt: "Cari catatan...")
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
            .sheet(isPresented: $showingEditNote) {
                if let note = selectedNote {
                    EditNoteView(note: note) { id, title, content in
                        viewModel.updateNote(id: id, title: title, content: content)
                    }
                }
            }
            .alert("Hapus Catatan?", isPresented: $showDeleteAlert) {
                Button("Hapus", role: .destructive) {
                    if let offsets = deleteOffsets {
                        viewModel.deleteNotes(at: offsets)
                    }
                }
                Button("Batal", role: .cancel) {}
            } message: {
                Text("Catatan yang dihapus tidak dapat dikembalikan.")
            }
            .overlay {
                if filteredNotes.isEmpty {
                    Text("Belum ada catatan, tap + untuk menambah")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
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
