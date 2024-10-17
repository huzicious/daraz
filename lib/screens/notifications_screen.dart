import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Helpers/notifiaction_screen_provider.dart'; // Ensure this import path is correct.

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.qr_code_scanner_outlined),
        title: Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Find what you love',
                  hintStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
              ),
              Positioned(
                right: 12,
                top: 5,
                bottom: 5,
                child: Container(
                  height: 32.0,
                  width: 80.0,
                  child: TextButton(
                    onPressed: () {
                      // Implement search functionality
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Search',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if(notificationProvider.productDetailsList.isEmpty)
            {
              return
            Center(child: Text('No Notification to show'));
            }
          else {
            return
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount: notificationProvider.productDetailsList.length,
                  itemBuilder: (context, index) {
                    final productDetail =
                        notificationProvider.productDetailsList[index];

                    return ListTile(
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(productDetail['image']),
                      ),
                      title: Text('You bought ${productDetail['title']}'),
                      subtitle:
                          Text('Price: \$${productDetail['price'].toString()}'),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
