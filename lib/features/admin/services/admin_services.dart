import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:estoregpt/core/error/error_handler.dart';
import 'package:estoregpt/core/utils/custom_dialogs.dart';
import 'package:estoregpt/core/utils/global_constants.dart';
import 'package:estoregpt/features/admin/providers/user_provider.dart';
import 'package:estoregpt/features/admin/screens/add_product_screen.dart';
import 'package:estoregpt/features/search/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<XFile> images,
    required String brand,
    required int discountPercentage,
    required List<String> colors,
    required String size,
    required String specifications,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      showDialogLoader(context);
      final cloudinary = CloudinaryPublic('dq60qoglh', 'by2b063b');
      //Maping througn all the images and sending them to the clouinary storage
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          //passing the folder name as the name of the product
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );

        imageUrls.add(res.secureUrl);
      }
      //uploading product url to mongoDb
      Product product = Product(
        name: name,
        description: description,
        images: imageUrls,
        quantity: quantity,
        price: price,
        ratings: [],
        colors: colors,
        brand: brand,
        size: size,
        discountPercentage: discountPercentage,
        category: category,
        seller: '',
        specifications: specifications,
      );

      http.Response res = await http.post(
        Uri.parse('$uri_2/add_product/'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          // 'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(product.toJson()),
      );
      Navigator.pop(context);

      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          showAlertMessage(
            context: context,
            title: "Successful",
            message: "Product added successfully",
            onTap: () {
              Navigator.pop(context);
            },
          );
          // Navigator.pop(context);
        },
      );
    } catch (e) {
      print("Add product Error: $e");
    }
  }

  void loginInAdmin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri_1/admin/loginAdmin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamed(context, AddProductScreen.route);
          });
    } on Error catch (e) {
      print('Login Error: $e');
    }
  }

  Future obtainTokenAndUserData(
    BuildContext context,
  ) async {
    try {
      //showDialogLoader(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('x-auth-token');

      if (authToken == null) {
        prefs.setString('x-auth-token', '');
      }

      var returnedTokenResponse = await http
          .post(Uri.parse('$uri_1/checkToken'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': authToken!
      });
      //the response will supply us with true or false according to the tokenIsValid api
      var response = jsonDecode(returnedTokenResponse.body);

      if (response == true) {
        //get user data

        http.Response returnedUserResponse =
            await http.get(Uri.parse('$uri_1/'), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': authToken,
        });

        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        );
        userProvider.setUser(returnedUserResponse.body);
        //Navigator.of(context, rootNavigator: true).pop('dialog');
      }
      return response;
    } catch (e) {
      print(e);
    }
  }
}
