import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addProduct(String title, double price, String imageAddress) {
    _cartItems.add({
      'title': title,
      'price': price,
      'imageAddress': imageAddress,
    });
    notifyListeners();
  }

  void removeProduct(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }
}
