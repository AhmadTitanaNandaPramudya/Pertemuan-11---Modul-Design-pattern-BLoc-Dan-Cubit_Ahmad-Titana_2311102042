// lib/blocs/cart_state.dart

import 'package:equatable/equatable.dart';
import '../models/product.dart';

class CartState extends Equatable {
  final List<Product> items;

  const CartState({this.items = const []});

  // Total jumlah item di keranjang
  int get totalItems => items.length;

  // Total harga
  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.price);

  // Cek apakah produk sudah ada di keranjang
  bool contains(Product product) => items.contains(product);

  // Buat state baru dengan list yang diperbarui
  CartState copyWith({List<Product>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object> get props => [items];
}
