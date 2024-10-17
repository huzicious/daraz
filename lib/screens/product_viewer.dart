import 'package:daraz_clone/Helpers/server_key.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Helpers/provider.dart';
import '../Helpers/wishList_provider.dart';
import 'buy_now.dart';

class ProductViewer extends StatefulWidget {
  final String imageAdress;
  final String title;
  final String description;
  final double price;
  final double originalPrice;

  const ProductViewer({
    Key? key,
    required this.imageAdress,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
  }) : super(key: key);

  @override
  State<ProductViewer> createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Product Image Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              width: width,
              child: Image.network(
                height: height * 0.3,
                widget.imageAdress.isNotEmpty
                    ? widget.imageAdress
                    : 'https://via.placeholder.com/150', // Fallback image
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                      child:
                          Icon(Icons.error, color: Colors.red)); // Error icon
                },
              ),
            ),
            SizedBox(height: 10),

            // Product Info Section
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Discount Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '\$',
                          style: GoogleFonts.aclonica(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.price.toStringAsFixed(2), // Current Price
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.originalPrice
                              .toStringAsFixed(2), // Original Price
                          style: GoogleFonts.abel(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.orange.shade100,
                          child: Text(
                            '-40%',
                            style: GoogleFonts.lato(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Title Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),

                  // Description Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.description,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Return and Delivery Info Section
                  Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white70,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.verified_user_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '14 Days Easy Return',
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.card_giftcard,
                                        color: Colors.grey.shade600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Delivery in 3-4 Days',
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Rs 125',
                                      style: GoogleFonts.lato(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.18),
                                    child: Text(
                                      'Standard Delivery',
                                      style: GoogleFonts.lato(fontSize: 14),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Multan',
                                      style: GoogleFonts.lato(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar for "Add to Cart" and "Buy Now"
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Favorite Icon Button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 29,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  final WishListProvider =
                      Provider.of<wishListProvider>(context, listen: false);

                  if (isFavorite == true) {
                    WishListProvider.removeProduct(
                        widget.title, widget.price, widget.imageAdress);
                  } else {
                    WishListProvider.addProduct(
                        widget.title, widget.price, widget.imageAdress);
                  }

                  setState(() {
                    isFavorite = !isFavorite;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isFavorite
                            ? 'Added to wishlist'
                            : 'Removed from wishlist'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                },
              ),
              // SizedBox(width: 10),

              // Add to Cart Button
              Consumer2<ProductProvider, wishListProvider>(
                builder: (context, productProvider, wishListProvider, child) =>
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade800,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    GoogleAuthService authService = GoogleAuthService();
                    String token = await authService.getServerKeyToken();
                    print("Server Key Token: $token");

                    productProvider.addProduct(widget.title, widget.price,
                        widget.imageAdress); // Add product to cart
                    print(productProvider.cartItems);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to Cart'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    'Add to Cart',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),

              // Buy Now Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.to(BuyNow(
                    image: widget.imageAdress,
                    title: widget.title,
                    price: widget.price,
                    description: widget.description,
                  ));
                },
                child: Text(
                  'Buy Now',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
