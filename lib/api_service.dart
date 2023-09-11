import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart'; // Define your models here

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
