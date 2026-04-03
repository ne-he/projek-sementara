import SwiftUI

struct EditNoteView: View {
    @Environment(\.dismiss) private var dismiss

    let note: Note
    var onUpdate: (UUID, String, String) -> Void

    @State private var titleInput: String
    @State private var contentInput: String
    @State private var showAlert = false
    @State private var alertMessage = ""

    init(note: Note, onUpdate: @escaping (UUID, String, String) -> Void) {
        self.note = note
        self.onUpdate = onUpdate
        _titleInput = State(initialValue: note.title)
        _contentInput = State(initialValue: note.content)
    }

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
            .navigationTitle("Edit Catatan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Batal") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Update") {
                        let trimmedTitle = titleInput.trimmingCharacters(in: .whitespaces)
                        let trimmedContent = contentInput.trimmingCharacters(in: .whitespaces)
                        if trimmedTitle.isEmpty {
                            alertMessage = "Judul tidak boleh kosong."
                            showAlert = true
                        } else if trimmedContent.isEmpty {
                            alertMessage = "Isi catatan minimal 1 karakter."
                            showAlert = true
                        } else {
                            onUpdate(note.id, trimmedTitle, trimmedContent)
                            dismiss()
                        }
                    }
                }
            }
            .alert("Validasi Gagal", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}
