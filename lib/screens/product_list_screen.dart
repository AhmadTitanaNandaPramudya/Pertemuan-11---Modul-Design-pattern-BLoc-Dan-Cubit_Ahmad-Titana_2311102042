// lib/screens/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  String _formatRupiah(double price) {
    final parts = price.toStringAsFixed(0).split('');
    final result = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      if (i > 0 && (parts.length - i) % 3 == 0) result.write('.');
      result.write(parts[i]);
    }
    return 'Rp ${result.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Toko Ahmad Store',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
        actions: [
          // Badge jumlah item keranjang — menggunakan BlocBuilder
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<CartBloc>(),
                      child: const CartScreen(),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                      if (state.totalItems > 0)
                        Positioned(
                          right: 0,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '${state.totalItems}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner ringkasan keranjang
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: state.totalItems > 0 ? 56 : 0,
                child: Container(
                  color: const Color(0xFF1D4ED8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🛒 ${state.totalItems} item di keranjang',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        _formatRupiah(state.totalPrice),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Daftar produk
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dummyProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: dummyProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
