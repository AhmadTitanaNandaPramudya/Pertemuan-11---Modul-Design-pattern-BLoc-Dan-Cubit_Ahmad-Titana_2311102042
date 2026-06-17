// lib/blocs/cart_event.dart

import 'package:equatable/equatable.dart';
import '../models/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// Event: tambah produk ke keranjang
class AddToCart extends CartEvent {
  final Product product;
  const AddToCart(this.product);

  @override
  List<Object> get props => [product];
}

// Event: hapus produk dari keranjang
class RemoveFromCart extends CartEvent {
  final Product product;
  const RemoveFromCart(this.product);

  @override
  List<Object> get props => [product];
}

// Event: kosongkan seluruh keranjang
class ClearCart extends CartEvent {
  const ClearCart();
}
