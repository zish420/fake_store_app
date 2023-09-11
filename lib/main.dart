import 'package:flutter/material.dart';
import 'product_list_page.dart'; // Import your main page

void main() {
  runApp(const MyApp()); // Use your app's main class here
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListPage(), // Your home page or initial route
    );
  }
}
