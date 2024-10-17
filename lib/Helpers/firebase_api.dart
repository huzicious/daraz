// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
//
// class FireBaseAPI {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initNotification() async {
//     // Request permission for iOS devices
//     await _firebaseMessaging.requestPermission();
//
//     // Get the FCM token
//     String? fcmToken = await _firebaseMessaging.getToken();
//     print(fcmToken);
//
//     // Set the background message handler
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
// }
//
// // Background message handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Handle the background message here
//   print('Handling a background message: ${message.messageId}');
//
//   // You can add code to process the message, like displaying a local notification
//   // or updating local data based on the notification content.
// }
