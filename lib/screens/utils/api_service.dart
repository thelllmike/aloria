import 'package:aloria/models/Cartmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8001';

  static Future<http.Response> getProducts() async {
    final url = Uri.parse('$baseUrl/products/products-mage/');
    return await http.get(url);
  }

  static Future<http.Response> addToCart(int userId, int productId, int quantity) async {
    final url = Uri.parse('$baseUrl/cart/cart/');
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
    });

    return await http.post(url, headers: headers, body: body);
  }
  static Future<List<CartItem>> getCartItems(int userId) async {
    final url = Uri.parse('$baseUrl/cart/cart/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CartItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}
