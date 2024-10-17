import 'dart:convert';
import 'package:daraz_clone/Helpers/buy_now_provider.dart';
import 'package:daraz_clone/Helpers/notifiaction_screen_provider.dart';
import 'package:daraz_clone/navbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Import the NotificationService
import '../Helpers/notification_service.dart';

class BuyNow extends StatefulWidget {
  final String image;
  final String title;
  final double price;
  final String? description; // Make description nullable

  BuyNow({
    required this.image,
    required this.title,
    required this.price,
    this.description, // Nullable description
    super.key,
  });

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Delivery price for standard delivery
  final double deliveryPrice = 2.5;

  // Create an instance of NotificationService
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    // Initialize local notifications
    notificationService.initLocalNotifications();
  }

  @override
  void dispose() {
    // Dispose controllers when not needed
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Total price includes product price + delivery price
    double totalPrice = widget.price + deliveryPrice;

    return Scaffold(
      backgroundColor: Colors.grey.shade300, // Grey background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Checkout'),
      ),
      body: Consumer2<BuyNowProvider, NotificationProvider>(
        builder: (context, buyNowProvider, notificationProvider, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Key for form validation
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shipping Address Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        // Circular border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Add Shipping Address',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Phone Number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Standard Delivery Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        // Circular border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Standard Delivery',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '\$${deliveryPrice.toStringAsFixed(2)}',
                            // Delivery Price
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Product Details Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        // Circular border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            widget.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ), // Assuming widget.image is a URL
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: GoogleFonts.lato(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.description ??
                                      'No description available',
                                  // Provide a fallback
                                  style: GoogleFonts.lato(fontSize: 14),
                                  maxLines: 3,
                                  // Limit the description to 3 lines
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis if text overflows
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '\$${widget.price.toStringAsFixed(2)}',
                            // Product Price
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // Bottom Fixed Checkout Section
      bottomNavigationBar: Container(
        color: Colors.deepOrange, // Background color for checkout section
        padding: const EdgeInsets.all(9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}', // Total Price
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final notification =
                      Provider.of<NotificationProvider>(context, listen: false);
                  notification.addProductDetails(
                      widget.title, widget.image, widget.price);
                  final buyNowProvider =
                      Provider.of<BuyNowProvider>(context, listen: false);

                  // Add product details
                  buyNowProvider.addProductDetails(
                    widget.title,
                    widget.description ?? 'No description available',
                    widget.price,
                  );

                  // Add address details
                  buyNowProvider.addAddressDetails(
                    _nameController.text,
                    _addressController.text,
                    _phoneNumberController.text,
                    _cityController.text,
                  );

                  try {
                    // Simulate submitting data to your backend API
                    await submitDataToApi(
                      _nameController.text,
                      _addressController.text,
                      _phoneNumberController.text,
                      _cityController.text,
                      buyNowProvider.productDetailsList,
                    );

                    // **Show the local notification**
                    await notificationService.showLocalNotification(
                      'Order Placed',
                      'You bought ${widget.title}',
                    );

                    // Show a confirmation dialog
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Order Confirmation'),
                          content: const Text(
                              'Your order has been placed successfully!'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyNavigationBar()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (error) {
                    print('Error occurred: $error');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            'Failed to place order. Please try again later.'),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepOrange,
              ),
              child: Text(
                'Checkout',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to submit data to your backend API
  Future<void> submitDataToApi(
    String name,
    String address,
    String phoneNumber,
    String city,
    List<Map<String, dynamic>> productDetails,
  ) async {
    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate a successful response
    print('Order successfully placed with the following details:');
    print('Name: $name, Address: $address, Phone: $phoneNumber, City: $city');
    print('Products: $productDetails');
  }
}
