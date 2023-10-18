import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_snap/constants/constants.dart';
import 'package:shop_snap/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productmodel;
  List<ProductModel> productModelList = [];
  bool isLoading = true;

  Future<void> fetchAllProducts() async {
    isLoading = true;

    try {
      const String url = "https://api.escuelajs.co/api/v1/products";
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        for (Map<String, dynamic> val in data) {
          productmodel = ProductModel.fromJson(val);
          productModelList.add(productmodel!);
        }
        log(productModelList[0].category!.image.toString());

        notifyListeners();
      } else {
        showMessage("Couldn't able to fetch products!!", Colors.red);
        notifyListeners();
      }
    } catch (e) {
      showMessage(e.toString(), Colors.red);
      notifyListeners();
    }

    isLoading = false;
  }
}
