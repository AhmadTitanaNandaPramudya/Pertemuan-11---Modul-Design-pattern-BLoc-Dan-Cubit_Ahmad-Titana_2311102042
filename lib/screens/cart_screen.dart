// lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) => Text(
            'Keranjang (${state.totalItems} item)',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFF2563EB),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Tombol kosongkan keranjang
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.totalItems == 0) return const SizedBox();
              return IconButton(
                icon: const Icon(Icons.delete_sweep, color: Colors.white),
                tooltip: 'Kosongkan keranjang',
                onPressed: () {
                  context.read<CartBloc>().add(const ClearCart());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Keranjang dikosongkan'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.totalItems == 0) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🛒', style: TextStyle(fontSize: 64)),
                  SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tambahkan produk dari halaman utama',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final product = state.items[index];
                    return _CartItemTile(product: product);
                  },
                ),
              ),
              // Ringkasan total
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total (${state.totalItems} item):',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          _formatRupiah(state.totalPrice),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '✅ Pesanan ${state.totalItems} item dikonfirmasi!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final Product product;
  const _CartItemTile({required this.product});

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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(product.emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  _formatRupiah(product.price),
                  style: const TextStyle(
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () {
              context.read<CartBloc>().add(RemoveFromCart(product));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} dihapus dari keranjang'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.orange,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
