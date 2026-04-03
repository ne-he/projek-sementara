# Requirements Document

## Introduction

SimpleNotesApp adalah aplikasi catatan sederhana berbasis SwiftUI yang ditujukan untuk pemula iOS/macOS. Aplikasi ini memungkinkan pengguna melihat daftar catatan, dengan arsitektur MVVM menggunakan ObservableObject dan SwiftUI lifecycle modern.

## Glossary

- **App**: SwiftUI App struct sebagai entry point aplikasi
- **Note**: Model data yang merepresentasikan satu catatan
- **NotesViewModel**: ObservableObject yang mengelola state dan logika daftar catatan
- **ContentView**: Tampilan utama yang menampilkan daftar catatan
- **NoteRow**: Komponen tampilan satu baris catatan dalam List

## Requirements

### Requirement 1: Struktur Model Data

**User Story:** As a developer, I want a well-defined Note model, so that I can represent note data consistently throughout the app.

#### Acceptance Criteria

1. THE Note SHALL be defined as a Swift struct conforming to Identifiable
2. THE Note SHALL have a property `id` of type UUID with a default value of `UUID()`
3. THE Note SHALL have a property `title` of type String
4. THE Note SHALL have a property `content` of type String
5. THE Note SHALL have a property `createdAt` of type Date with a default value of `Date()`

### Requirement 2: ViewModel dan State Management

**User Story:** As a developer, I want a ViewModel that manages notes state, so that the UI can reactively update when data changes.

#### Acceptance Criteria

1. THE NotesViewModel SHALL be defined as a class conforming to ObservableObject
2. THE NotesViewModel SHALL expose a `@Published var notes: [Note]` property initialized as an empty array
3. THE NotesViewModel SHALL implement a method `loadSampleNotes()` that populates `notes` with at least 2 sample Note objects
4. WHEN NotesViewModel is initialized, THE NotesViewModel SHALL call `loadSampleNotes()` automatically

### Requirement 3: Tampilan Daftar Catatan

**User Story:** As a user, I want to see a list of my notes, so that I can quickly browse all available notes.

#### Acceptance Criteria

1. THE ContentView SHALL use `@StateObject` to instantiate and hold a NotesViewModel instance
2. THE ContentView SHALL display a NavigationView containing a List of notes
3. WHEN the List is rendered, THE ContentView SHALL display a NoteRow for each Note in the ViewModel's notes array
4. THE ContentView SHALL display a navigation bar title "Catatan Saya"
5. THE ContentView SHALL display an "Add" button (labeled "Tambah") in the navigation bar trailing position

### Requirement 4: Tampilan Baris Catatan

**User Story:** As a user, I want each note row to show the title and date, so that I can identify notes at a glance.

#### Acceptance Criteria

1. THE NoteRow SHALL display the `title` of the Note in a prominent text style
2. THE NoteRow SHALL display the `createdAt` date of the Note formatted as a short date string
3. THE NoteRow SHALL arrange the title and date in a vertical stack (VStack)

### Requirement 5: Entry Point Aplikasi

**User Story:** As a developer, I want a standard SwiftUI App entry point, so that the app launches correctly on iOS and macOS.

#### Acceptance Criteria

1. THE App SHALL be defined using the `@main` attribute and conform to the SwiftUI `App` protocol
2. THE App SHALL declare a `WindowGroup` containing ContentView as the root scene
