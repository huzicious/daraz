import 'package:daraz_clone/Helpers/notification_service.dart';
import 'package:daraz_clone/screens/product_viewer.dart';
import 'package:daraz_clone/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Helpers/flash_sale_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Variable to store fetched data
  List<Map<String, dynamic>> recommendedProducts = [];

  // Function to fetch data from the API
  Future<void> fetchRecommendedProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          recommendedProducts =
              data.map((item) => Map<String, dynamic>.from(item)).toList();
        });
        print('Fetched data: $recommendedProducts');
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }
NotificationService notificationService = NotificationService();


  @override
  void initState() {
    super.initState();
    fetchRecommendedProducts();
    notificationService.token();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 120.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: [
                      'assets/5.jpeg',
                      'assets/2.jpeg',
                      'assets/3.jpeg',
                      'assets/4.jpeg',

                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(i, fit: BoxFit.cover,))

                            ,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 4; i++)
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == i
                                  ? Colors.deepOrange
                                  : Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: height * 0.15,
              width: width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Daraz Offers',
                            style: GoogleFonts.aclonica(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'More Deals >',
                          style: GoogleFonts.lato(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.grey.shade100,
                          height: height * 0.1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Free Shipping',
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.green,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      margin:  EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade800,
                                      ),
                                      child: Text(
                                        'Offers',
                                        style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Over Shopping Rs.3000+',
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/delivery.png',
                          height: height * 0.1,
                          width: width * 0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Flash Sale',
                      style: GoogleFonts.aclonica(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4, // Number of flash sale cards to display
                        (index) {
                          final flashProduct = recommendedProducts.isNotEmpty
                              ? recommendedProducts[index]
                              : {}; // Ensure there's data
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: (){
                                  print(flashProduct['id']);
                                  Get.to(ProductViewer( imageAdress: flashProduct['image'],
                                    title: flashProduct['title'],
                                    description: flashProduct['description'],
                                    price: (flashProduct['price'] as num).toDouble(), // Convert to double
                                    originalPrice: (flashProduct['price'] * 1.4).toDouble(),));
                                },
                                child: FlashSaleCard(
                                  price: flashProduct['price']
                                          ?.toDouble()
                                          .toString() ??
                                      '0.00',
                                  originalPrice: (flashProduct['price'] != null
                                          ? flashProduct['price'] * 1.4
                                          : 0)
                                      .toStringAsFixed(2),
                                  imageAdress: flashProduct['image'] ?? '',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Recommended Products Section
            Container(
              color: Colors.white,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recommended Products',
                      style: GoogleFonts.aclonica(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: recommendedProducts.length,
                    itemBuilder: (context, index) {
                      final product = recommendedProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            ProductViewer(
                              imageAdress: product['image'],
                              title: product['title'],
                              description: product['description'],
                              price: (product['price'] as num).toDouble(), // Convert to double
                              originalPrice: (product['price'] * 1.4).toDouble(), // Convert to double
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      product['image'] ?? 'https://via.placeholder.com/150',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(child: Icon(Icons.error, color: Colors.red));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product['title'] ?? 'Product Title',
                                  style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '\$${(product['price'] as num).toDouble().toStringAsFixed(2)}',
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                        fontSize: 22,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.orange.shade200,
                                    child: Text(
                                      '\$${((product['price'] as num) * 1.4).toDouble().toStringAsFixed(2)}',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
