# SimpleNotesApp

Aplikasi catatan sederhana berbasis SwiftUI untuk iOS 16+.

## Cara Menjalankan

1. Buka Xcode (versi 15+)
2. Buka folder `SimpleNotesApp/`
3. Pilih simulator iPhone (iOS 16+)
4. Tekan **Run** (⌘R)

> Atau via Swift Package Manager:
> ```
> swift run
> ```

## Fitur

- Tambah, edit, dan hapus catatan
- Kategori catatan: Pribadi, Pekerjaan, Lainnya (dengan warna & ikon berbeda)
- Bagikan catatan via swipe kiri → tombol Share
- Hapus semua catatan sekaligus (dengan konfirmasi)
- Pencarian catatan berdasarkan judul & isi
- Tampilkan tanggal dibuat / tanggal diubah di setiap baris
- Penyimpanan otomatis ke UserDefaults
- Splash screen animasi saat pertama buka

## Screenshot

| Daftar Catatan | Tambah Catatan | Edit Catatan |
|---|---|---|
| _(placeholder)_ | _(placeholder)_ | _(placeholder)_ |

## Teknologi

- SwiftUI
- UserDefaults (persistensi lokal)
- ShareLink (iOS 16+)
- MVVM pattern
