
# flutter_cart_bloc

Aplikasi Flutter — Daftar Produk dengan BLoC State Management

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Struktur Proyek

```
lib/
├── main.dart                    # Entry point + BlocProvider
├── models/
│   └── product.dart             # Model Product + dummy data
├── blocs/
│   ├── cart_bloc.dart           # CartBloc (logika bisnis)
│   ├── cart_event.dart          # AddToCart, RemoveFromCart, ClearCart
│   └── cart_state.dart          # CartState (items, totalItems, totalPrice)
├── screens/
│   ├── product_list_screen.dart # Halaman daftar produk
│   └── cart_screen.dart         # Halaman keranjang
└── widgets/
    └── product_card.dart        # Widget kartu produk
```

## Fitur

- ✅ Daftar 7 produk elektronik
- ✅ Tambah produk ke keranjang
- ✅ Hapus produk dari keranjang
- ✅ Badge jumlah item real-time di AppBar
- ✅ Banner ringkasan harga real-time
- ✅ Halaman keranjang dengan total harga
- ✅ Checkout & kosongkan keranjang
