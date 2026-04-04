import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNote = false
    @State private var deleteOffsets: IndexSet?
    @State private var showDeleteAlert = false
    @State private var showDeleteAllSheet = false
    @State private var selectedNote: Note?
    @State private var showingEditNote = false
    @State private var searchText = ""

    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return viewModel.notes
        }
        return viewModel.notes.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }
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
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            ShareLink(
                                item: "\(note.title)\n\n\(note.content)",
                                preview: SharePreview(note.title)
                            ) {
                                Label("Bagikan", systemImage: "square.and.arrow.up")
                            }
                            .tint(.blue)
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
                if !viewModel.notes.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Button(role: .destructive) {
                            showDeleteAllSheet = true
                        } label: {
                            Label("Hapus Semua", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView { title, content, category in
                    viewModel.addNote(title: title, content: content, category: category)
                }
            }
            .sheet(isPresented: $showingEditNote) {
                if let note = selectedNote {
                    EditNoteView(note: note) { id, title, content, category in
                        viewModel.updateNote(id: id, title: title, content: content, category: category)
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
            .confirmationDialog(
                "Hapus semua catatan?",
                isPresented: $showDeleteAllSheet,
                titleVisibility: .visible
            ) {
                Button("Hapus Semua", role: .destructive) {
                    viewModel.deleteAllNotes()
                }
                Button("Batal", role: .cancel) {}
            } message: {
                Text("Semua catatan akan dihapus permanen.")
            }
            .overlay {
                if filteredNotes.isEmpty {
                    Text(searchText.isEmpty ? "Belum ada catatan, tap + untuk menambah" : "Tidak ada catatan yang cocok.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

struct NoteRow: View {
    let note: Note

    static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()

    var categoryColor: Color {
        switch note.category {
        case .pribadi: return .blue
        case .pekerjaan: return .orange
        case .lainnya: return .green
        }
    }

    var wasEdited: Bool {
        abs(note.updatedAt.timeIntervalSince(note.createdAt)) > 1
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: note.category.icon)
                .foregroundColor(categoryColor)
                .frame(width: 32, height: 32)
                .background(categoryColor.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(note.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text(note.category.rawValue)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(categoryColor.opacity(0.15))
                        .foregroundColor(categoryColor)
                        .clipShape(Capsule())
                }
                if wasEdited {
                    Text("Diubah: \(NoteRow.dateFormatter.string(from: note.updatedAt))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text(NoteRow.dateFormatter.string(from: note.createdAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
