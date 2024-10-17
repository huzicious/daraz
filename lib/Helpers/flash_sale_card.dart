import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges; // Import with alias to avoid conflicts
import 'package:google_fonts/google_fonts.dart';

class FlashSaleCard extends StatelessWidget {
  final String price; // Add this field to make price required
  final String originalPrice;
  final String imageAdress;
 // final String title;// Add this field to make originalPrice required

  const FlashSaleCard({
    super.key,
    required this.price,
    required this.originalPrice,
    required this.imageAdress,
    // required this.title,


    // required String description, required String title, required double height,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      width: width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -10), // Adjust badge position
              badgeContent: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0), // Adjusts the width of the badge
                child: Text(
                  ' Sale',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), // Enhanced text style
                ),
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.pinkAccent, // Shocking pink color
                borderRadius: BorderRadius.circular(8), // Slightly rounded corners
              ),
              child: Image(
                height: height * 0.1,
                image: NetworkImage(imageAdress),
              ),
            ),
          ),
          Container(
            width: width * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price, // Use the required price here
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    originalPrice, // Use the required originalPrice here
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}