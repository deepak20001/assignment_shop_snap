import 'package:flutter/material.dart';
import '../models/product_model.dart';

class FavouriteProvider with ChangeNotifier {
  List<ProductModel> _favouriteList = [];
  List<ProductModel>? get favouriteList => _favouriteList;

  void toggleFavourite(ProductModel product) {
    final isExist = _favouriteList.contains(product);
    if (isExist) {
      _favouriteList.remove(product);
    } else {
      _favouriteList.add(product);
    }

    notifyListeners();
  }

  bool isFavourite(ProductModel product) {
    final isExist = _favouriteList.contains(product);
    return isExist;
  }

  void clearFavourite() {
    _favouriteList = [];

    notifyListeners();
  }
}
