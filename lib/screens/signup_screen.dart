import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isSigningUp = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    usernameController.dispose();
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
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection:
          Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              Center(
                child: Text(
                  'Welcome to Daraz',
                  style: GoogleFonts.lato(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Daraz',
                  style: GoogleFonts.lato(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
              Center(
                child: Text(
                  'Discover the Endless Possibilities',
                  style: GoogleFonts.lato(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Signup',
                  style: GoogleFonts.lato(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepOrange,
                    ),
                    labelText: 'Username',
                    border: OutlineInputBorder(),
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
                  onPressed: _isSigningUp ? null : _signUp,
                  child: _isSigningUp
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'Sign Up',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Already Have an Account?',
                  style: GoogleFonts.lato(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back(); // Navigate back to login screen
                  },
                  child: Text(
                    'Login',
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

  // Firebase sign-up logic
  void _signUp() async {
    setState(() {
      _isSigningUp = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Create a new user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If successful, show success snackbar and navigate to home or login screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to another screen (e.g., login or home screen)
      Get.toNamed("/home");

    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      // Handle Firebase sign-up errors
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }

      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSigningUp = false;
      });
    }
  }
}
class userName{
  String Name(String name){
    String Username = name;
    return Username;
  }
}