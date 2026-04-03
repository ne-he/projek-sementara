import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var titleInput: String = ""
    @State private var contentInput: String = ""

    var onSave: (String, String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Judul")) {
                    TextField("Masukkan judul catatan", text: $titleInput)
                }
                Section(header: Text("Isi")) {
                    TextEditor(text: $contentInput)
                        .frame(minHeight: 150)
                }
            }
            .navigationTitle("Catatan Baru")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Batal") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Simpan") {
                        onSave(titleInput, contentInput)
                        dismiss()
                    }
                    .disabled(titleInput.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
