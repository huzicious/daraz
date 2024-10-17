import 'package:daraz_clone/Helpers/wishList_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist'),),
      body: Consumer<wishListProvider>(
        builder: (context, WishListProvider, child) {
          if (WishListProvider.cartItems.isEmpty) {
            return const Center(
              child: Text('Your Cart is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: WishListProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = WishListProvider.cartItems[index];
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
                      // if (widget.onItemSelected != null) {
                      //   widget.onItemSelected!(item);
                      // }
                      // // Go back to the previous screen
                      // Navigator.pop(context);
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        bool confirmDelete = await showDeleteConfirmationDialog(context);
                        if (confirmDelete) {
                          WishListProvider.removeProductatIndex(index);
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
