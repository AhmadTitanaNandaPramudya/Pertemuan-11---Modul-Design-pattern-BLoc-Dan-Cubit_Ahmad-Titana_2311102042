// lib/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Emoji produk
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(product.emoji, style: const TextStyle(fontSize: 34)),
              ),
            ),
            const SizedBox(width: 14),
            // Info produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatRupiah(product.price),
                    style: const TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Tombol tambah/hapus — menggunakan BlocBuilder
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final inCart = state.contains(product);
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: inCart
                      ? _RemoveButton(
                          key: const ValueKey('remove'),
                          onTap: () {
                            context.read<CartBloc>().add(RemoveFromCart(product));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} dihapus dari keranjang'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          },
                        )
                      : _AddButton(
                          key: const ValueKey('add'),
                          onTap: () {
                            context.read<CartBloc>().add(AddToCart(product));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} ditambahkan ke keranjang'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: Colors.white, size: 16),
          SizedBox(width: 4),
          Text('Tambah', style: TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RemoveButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFEE2E2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.red, size: 16),
          SizedBox(width: 4),
          Text('Ditambah', style: TextStyle(color: Colors.red, fontSize: 13)),
        ],
      ),
    );
  }
}
