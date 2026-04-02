import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.notes) { note in
                NoteRow(note: note)
            }
            .navigationTitle("Catatan Saya")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tambah") {
                        // TODO: tambahkan aksi di sini
                    }
                }
            }
        }
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
