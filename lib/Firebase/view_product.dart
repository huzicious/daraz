import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Products')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var products = snapshot.data?.docs;
          return ListView.builder(
            itemCount: products?.length,
            itemBuilder: (context, index) {
              var product = products?[index];
              return ListTile(
                title: Text(product?['name']),
                subtitle: Text('Price: ${product?['price']}'),
              );
            },
          );
        },
      ),
    );
  }
}
