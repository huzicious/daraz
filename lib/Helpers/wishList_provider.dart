import 'package:flutter/cupertino.dart';
class wishListProvider extends ChangeNotifier{
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

  void removeProductatIndex(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }
  void removeProduct(String title, double price, String imageAddress) {
    _cartItems.removeWhere((item) =>
    item['title'] == title &&
        item['price'] == price &&
        item['imageAddress'] == imageAddress
    );
    notifyListeners();
  }}

