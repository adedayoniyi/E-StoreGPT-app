import 'dart:convert';

import 'package:estoregpt/core/utils/global_constants.dart';
import 'package:estoregpt/features/search/models/searched_product_model.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<String> generateWelcomeResponse() async {
    // String response = '';
    try {
      http.Response res = await http.get(
          Uri.parse("$uri_2/generate_response?question=Tell me about yourself"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['response'];
      } else {
        throw Exception(
            'Failed to load response, status code: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<SearchedProduct> searchProduct({required String query}) async {
    final response = await http.post(Uri.parse('$uri_2/process/'),
        body: jsonEncode({'user_prompt': query}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (responseBody.containsKey('products')) {
        // If the 'products' key exists in the response, parse the response normally
        return SearchedProduct.fromJson(responseBody);
      } else if (responseBody.containsKey('message')) {
        // If only the 'message' key exists in the response, return a SearchedProduct with an empty products list and the given message
        return SearchedProduct(products: [], message: responseBody['message']);
      } else {
        // If the response is unexpected, return a generic error message
        return SearchedProduct(
            products: [], message: 'Unexpected server response');
      }
    } else {
      // If the server did not return a 200 OK response, return a SearchedProduct with a message indicating a server error
      return SearchedProduct(
          products: [], message: jsonDecode(response.body)['message']);
    }
  }
}
