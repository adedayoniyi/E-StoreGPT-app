// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String name;
  String description;
  List<String> images;
  int quantity;
  int price;
  List<dynamic> ratings;
  List<String> colors;
  String brand;
  String size;
  int discountPercentage;
  String category;
  String seller;
  String specifications;

  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.ratings,
    required this.colors,
    required this.brand,
    required this.size,
    required this.discountPercentage,
    required this.category,
    required this.seller,
    required this.specifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"],
        price: json["price"],
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
        brand: json["brand"],
        size: json["size"],
        discountPercentage: json["discount_percentage"],
        category: json["category"],
        seller: json["seller"],
        specifications: json["specifications"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "quantity": quantity,
        "price": price,
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "brand": brand,
        "size": size,
        "discount_percentage": discountPercentage,
        "category": category,
        "seller": seller,
        "specifications": specifications,
      };
}
