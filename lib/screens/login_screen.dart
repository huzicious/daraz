import 'package:daraz_clone/Helpers/notification_service.dart';
import 'package:daraz_clone/navbar.dart';
import 'package:daraz_clone/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Helpers/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isSigning = false;

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              Center(
                child: Text(
                  'Daraz',
                  style: GoogleFonts.lato(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Discover the Endless Possibilities',
                  style: GoogleFonts.lato(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.lato(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.deepOrange,
                    ),
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.deepOrange,
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width, 30),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: _isSigning ? null : _signIn,
                  child: _isSigning
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'LogIn',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Don\'t Have Account?',
                  style: GoogleFonts.lato(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(SignupScreen());
                  },
                  child: Text(
                    'Signup',
                    style: GoogleFonts.lato(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    NotificationService notificationService = NotificationService();
    setState(() {
      _isSigning = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    // Get the FCM device token
    String? deviceToken = await notificationService.token();
    print('Device Token Get through Login: $deviceToken');

    // Log the user in
    User? user = await _auth.signInWithEmailAndPassword(
      email,
      password,
      context,
    );

    setState(() {
      _isSigning = false;
    });

    // If login was successful, show a success message and navigate to the home screen
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User is successfully signed in'),
          backgroundColor: Colors.green,
        ),
      );
      Get.to(MyNavigationBar());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
