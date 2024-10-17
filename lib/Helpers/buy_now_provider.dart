import 'package:flutter/material.dart';

class BuyNowProvider extends ChangeNotifier {
  // List to store product details
  List<Map<String, dynamic>> productDetailsList = [];

  // Variables to store address details
  String name = '';
  String address = '';
  String phoneNumber = '';
  String city = '';

  // Method to add product details
  void addProductDetails(String title, String description, double price) {
    productDetailsList.add({
      'title': title,
      'description': description,
      'price': price,
    });
    notifyListeners();
  }

  // Method to add address details
  void addAddressDetails(String name, String address, String phoneNumber, String city) {
    this.name = name;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.city = city;
    notifyListeners();
  }

  // Method to clear product and address details
  void clearData() {
    productDetailsList.clear();
    name = '';
    address = '';
    phoneNumber = '';
    city = '';
    notifyListeners();
  }
}
