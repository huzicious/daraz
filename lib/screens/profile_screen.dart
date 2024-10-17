import 'dart:io';
import 'package:daraz_clone/screens/add_to_cart.dart';
import 'package:daraz_clone/screens/help_screen.dart';
import 'package:daraz_clone/screens/notifications_screen.dart';
import 'package:daraz_clone/screens/wishList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  final List<IconData> _icons = [
    Icons.notifications_none_outlined,
    Icons.shopping_cart_outlined,
    Icons.favorite_border,
    Icons.help_outline_outlined,
  ];

  final List<String> _texts = [
    'Notifications',
    'Cart',
    'WishList',
    'Help',
  ];

  Future<void> _pickImage() async {
    await _requestPermissions();
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        print('Image picked: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();
    if (status.isGranted && storageStatus.isGranted) {
      print('Permissions granted');
    } else {
      print('Permissions denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: height * 0.035,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const NetworkImage(
                            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg',
                          ) as ImageProvider,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HuzaifaZebMirza',
                              style: GoogleFonts.lato(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.settings_outlined),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'My Orders',
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'View all Orders >',
                        style: GoogleFonts.lato(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // Notifications
                          GestureDetector(
                            onTap: () {
                              Get.to(NotificationScreen(), transition: Transition.rightToLeft);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    size: 30,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Notifications',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text('>', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                          // Cart
                          GestureDetector(
                            onTap: () {
                              Get.to(AddToCart(), transition: Transition.rightToLeft);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Cart',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text('>', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                          // WishList
                          GestureDetector(
                            onTap: () {
                              Get.to(Wishlist(), transition: Transition.rightToLeft);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'WishList',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text('>', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                          // Help
                          GestureDetector(
                            onTap: () {
                              Get.to(HelpScreen(), transition: Transition.rightToLeft);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.help,
                                    size: 30,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Help',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text('>', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
