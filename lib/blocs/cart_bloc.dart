// lib/blocs/cart_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // Inisialisasi dengan state kosong
  CartBloc() : super(const CartState()) {
    // Handler untuk setiap event
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  // Tambah produk ke keranjang (cegah duplikat)
  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (!state.contains(event.product)) {
      final updatedItems = List.of(state.items)..add(event.product);
      emit(state.copyWith(items: updatedItems));
    }
  }

  // Hapus produk dari keranjang
  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = List.of(state.items)
      ..remove(event.product);
    emit(state.copyWith(items: updatedItems));
  }

  // Kosongkan semua item
  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}
