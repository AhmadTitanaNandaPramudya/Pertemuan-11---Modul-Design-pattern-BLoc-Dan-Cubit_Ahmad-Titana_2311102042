// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart_bloc.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // BlocProvider menyediakan CartBloc ke seluruh widget tree
      create: (context) => CartBloc(),
      child: MaterialApp(
        title: 'Toko Ahmad Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2563EB),
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
