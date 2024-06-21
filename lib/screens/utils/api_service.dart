import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8001';

  static Future<http.Response> getProducts() async {
    final url = Uri.parse('$baseUrl/products/products-mage/');
    return await http.get(url);
  }
}
