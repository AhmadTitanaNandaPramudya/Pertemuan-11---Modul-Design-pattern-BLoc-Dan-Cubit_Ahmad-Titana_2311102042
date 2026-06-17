# 🛒 Toko Ahmad Store - BLoC State Management (Flutter)

Aplikasi berbasis Flutter ini dirancang untuk mendemonstrasikan implementasi pola arsitektur **BLoC (Business Logic Component)** dalam mengelola *state* keranjang belanja pada aplikasi e-commerce secara *real-time*.

---

## 👤 Informasi Mahasiswa

- **Nama:** Ahmad Titana Nanda Pramudya
- **Nim :** 2311102042
- **Program Studi:** Teknik Informatika
- **Kelas:** IF-11-02

---

## 📖 Gambaran Umum Aplikasi

Proyek ini memanfaatkan *package* dan pola desain utama:
1. `flutter_bloc`: Untuk memisahkan logika bisnis dari antarmuka pengguna (UI) dan mengelola perubahan *state* secara reaktif.

**Alur Kerja:**
Pengguna melihat katalog produk ➡️ Menekan tombol "Tambah" pada produk yang diinginkan ➡️ Aplikasi mengirimkan *Event* (`AddToCart`) ke BLoC ➡️ BLoC memproses dan menghasilkan *State* baru (jumlah & total harga) ➡️ Antarmuka (Badge AppBar, Banner Harga, dan Notifikasi) diperbarui secara dinamis pada saat itu juga.

---

## ✨ Fitur Utama

- ✅ **Daftar Produk Dinamis:** Menampilkan katalog 7 produk elektronik beserta harga dan spesifikasi ringkas.
- ✅ **Tambah & Hapus Item:** Interaksi mulus untuk menambahkan produk ke keranjang belanja atau menghapusnya.
- ✅ **Indikator Real-Time:** *Badge* jumlah item pada *AppBar* dan *Banner* ringkasan di bawah layar diperbarui seketika tanpa perlu memuat ulang halaman.
- ✅ **Halaman Keranjang Terpisah:** Menampilkan rincian belanja komprehensif yang mengkalkulasi dan menjumlahkan total harga otomatis.
- ✅ **Feedback Visual (SnackBar):** Notifikasi *pop-up* di bawah layar muncul sebagai konfirmasi saat status keranjang berubah (hijau untuk penambahan, oranye untuk penghapusan).
- ✅ **Simulasi Checkout:** Fitur untuk mengosongkan keranjang kembali ke status awal (0 item) setelah proses pembayaran disimulasikan selesai.

---

## 📂 Struktur Proyek

Aplikasi ini menggunakan pola arsitektur yang terstruktur rapi untuk memisahkan antarmuka pengguna dan logika bisnis:

```text
lib/
├── main.dart                    # Entry point + Inisialisasi BlocProvider Global
├── models/
│   └── product.dart             # Model data Product dan penyedia list dummy data
├── blocs/
│   ├── cart_bloc.dart           # File BLoC utama pemroses logika bisnis
│   ├── cart_event.dart          # Definisi interaksi: AddToCart, RemoveFromCart, ClearCart
│   └── cart_state.dart          # Representasi state: daftar item, total item, total harga
├── screens/
│   ├── product_list_screen.dart # Antarmuka utama (katalog produk)
│   └── cart_screen.dart         # Antarmuka detail keranjang belanja
└── widgets/
    └── product_card.dart        # Komponen widget modular untuk kartu produk
