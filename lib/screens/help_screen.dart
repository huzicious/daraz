
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Need Help?'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we assist you?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any queries, feel free to contact us here:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'support@example.com', // Replace with your email address
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'support@example.com', // Your email address
                    query: 'subject=Customer Support Query&body=Please describe your query here...', // Optional
                  );
                  print('Launching: ${emailLaunchUri.toString()}'); // Log the URI
                  if (await canLaunch(emailLaunchUri.toString())) {
                    await launch(emailLaunchUri.toString());
                  } else {
                    throw 'Could not launch $emailLaunchUri';
                  }
                },
                child: Text('Contact Support'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}