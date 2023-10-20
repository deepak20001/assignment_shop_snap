import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_snap/constants/constants.dart';
import 'package:shop_snap/models/category_model.dart';
import 'package:shop_snap/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productmodel;
  CategoryModel? categoryModel;
  List<ProductModel> productModelList = [];
  List<CategoryModel> categoryModelList = [];
  List<ProductModel> searchTitleList = [];
  bool isLoading = true;

  final String url = "https://api.escuelajs.co/api/v1/";

  Future<void> fetchAllProducts() async {
    try {
      const String productsEndPoint = "products";
      final res = await http.get(Uri.parse(url + productsEndPoint));

      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        for (Map<String, dynamic> val in data) {
          productmodel = ProductModel.fromJson(val);
          productModelList.add(productmodel!);
        }

        notifyListeners();
      } else {
        showMessage("Couldn't able to fetch products!!", Colors.red);
        notifyListeners();
      }
    } catch (e) {
      // print(e.toString());
      showMessage(e.toString(), Colors.red);
      notifyListeners();
    }
  }

  Future<void> fetchAllCategories() async {
    try {
      const String categoriesEndPoint = "categories";
      final res = await http.get(Uri.parse(url + categoriesEndPoint));

      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);

        for (Map<String, dynamic> val in data) {
          categoryModel = CategoryModel.fromJson(val);
          categoryModelList.add(categoryModel!);
        }

        // print(categoryModelList.toString());

        notifyListeners();
      } else {
        showMessage("Couldn't able to fetch products!!", Colors.red);
        notifyListeners();
      }
    } catch (e) {
      // print(e.toString());
      showMessage(e.toString(), Colors.red);
      notifyListeners();
    }
  }

  Future<void> filterProductsByTitle(String text) async {
    try {
      const String titleEndPoint = "products";
      final res = await http.get(Uri.parse(url + titleEndPoint));

      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        for (Map<String, dynamic> val in data) {
          productmodel = ProductModel.fromJson(val);
          if (productmodel!.title!
              .toLowerCase()
              .startsWith(text.toLowerCase())) {
            searchTitleList.add(productmodel!);
          }
          print(searchTitleList.toString());
        }

        notifyListeners();
      } else {
        showMessage("Couldn't able to fetch products!!", Colors.red);
        notifyListeners();
      }
    } catch (e) {
      showMessage(e.toString(), Colors.red);
      notifyListeners();
    }
  }

  Future<void> fetch() async {
    isLoading = true;

    await fetchAllProducts();
    await fetchAllCategories();

    isLoading = false;
  }
}
