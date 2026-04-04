import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var titleInput: String = ""
    @State private var contentInput: String = ""
    @State private var selectedCategory: NoteCategory = .lainnya
    @State private var showAlert = false
    @State private var alertMessage = ""

    var onSave: (String, String, NoteCategory) -> Void

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
                Section(header: Text("Kategori")) {
                    Picker("Kategori", selection: $selectedCategory) {
                        ForEach(NoteCategory.allCases, id: \.self) { cat in
                            Label(cat.rawValue, systemImage: cat.icon).tag(cat)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Catatan Baru")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Batal") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Simpan") {
                        let trimmedTitle = titleInput.trimmingCharacters(in: .whitespaces)
                        let trimmedContent = contentInput.trimmingCharacters(in: .whitespaces)
                        if trimmedTitle.isEmpty {
                            alertMessage = "Judul tidak boleh kosong."
                            showAlert = true
                        } else if trimmedContent.isEmpty {
                            alertMessage = "Isi catatan minimal 1 karakter."
                            showAlert = true
                        } else {
                            onSave(trimmedTitle, trimmedContent, selectedCategory)
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
