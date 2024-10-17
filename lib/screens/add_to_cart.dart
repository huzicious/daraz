import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Helpers/provider.dart';

class AddToCart extends StatefulWidget {
  final Function(Map<String, dynamic> item)? onItemSelected; // Add callback
  final String? imageUrl;
  final String? title;
  final double? price;

  const AddToCart({
    Key? key,
    this.imageUrl,
    this.title,
    this.price,
    this.onItemSelected, // Include callback here
  }) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Cart',
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.cartItems.isEmpty) {
            return const Center(
              child: Text('Your Cart is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: productProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = productProvider.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: Image.network(item['imageAddress']),
                    title: Text(item['title']),
                    subtitle: Text(
                      '\$${item['price'].toStringAsFixed(2)}',
                      style: GoogleFonts.lato(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Call the callback and pass the selected item
                      if (widget.onItemSelected != null) {
                        widget.onItemSelected!(item);
                      }
                      // Go back to the previous screen
                      Navigator.pop(context);
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        bool confirmDelete = await showDeleteConfirmationDialog(context);
                        if (confirmDelete) {
                          productProvider.removeProduct(index);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ??
        false;
  }
}
