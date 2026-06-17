// lib/models/product.dart

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final String emoji;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
  });

  @override
  List<Object> get props => [id];
}

// Daftar produk statis (minimal 5 produk)
final List<Product> dummyProducts = [
  const Product(
    id: 1,
    name: 'Laptop Gaming',
    description: 'Intel i7, 16GB RAM, RTX 4060',
    price: 14999000,
    emoji: '💻',
  ),
  const Product(
    id: 2,
    name: 'Wireless Headphone',
    description: 'Noise Cancelling, 30 jam battery',
    price: 1299000,
    emoji: '🎧',
  ),
  const Product(
    id: 3,
    name: 'Mechanical Keyboard',
    description: 'RGB, Tactile Switch, TKL Layout',
    price: 750000,
    emoji: '⌨️',
  ),
  const Product(
    id: 4,
    name: 'Monitor 27"',
    description: '2K IPS, 165Hz, 1ms Response',
    price: 3500000,
    emoji: '🖥️',
  ),
  const Product(
    id: 5,
    name: 'Mouse Gaming',
    description: '16000 DPI, 7 tombol programmable',
    price: 450000,
    emoji: '🖱️',
  ),
  const Product(
    id: 6,
    name: 'USB-C Hub',
    description: '7-in-1, HDMI 4K, 100W PD',
    price: 320000,
    emoji: '🔌',
  ),
  const Product(
    id: 7,
    name: 'SSD External 1TB',
    description: 'Read 1050MB/s, USB 3.2 Gen2',
    price: 850000,
    emoji: '💾',
  ),
];
