import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier{
  List<Map<String, dynamic>> productDetailsList = [];
  void addProductDetails(String title, String imageAdress, double price) {
    productDetailsList.add({
      'title': title,
      'image': imageAdress,
      'price': price,
    });
    notifyListeners();
  }
}
