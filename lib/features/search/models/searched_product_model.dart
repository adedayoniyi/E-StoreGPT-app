// To parse this JSON data, do
//
//     final searchedProduct = searchedProductFromJson(jsonString);

import 'dart:convert';

import 'package:estoregpt/features/search/models/product_model.dart';

SearchedProduct searchedProductFromJson(String str) =>
    SearchedProduct.fromJson(json.decode(str));

String searchedProductToJson(SearchedProduct data) =>
    json.encode(data.toJson());

class SearchedProduct {
  List<Product> products;
  String message;

  SearchedProduct({
    required this.products,
    required this.message,
  });

  factory SearchedProduct.fromJson(Map<String, dynamic> json) =>
      SearchedProduct(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "message": message,
      };
}
