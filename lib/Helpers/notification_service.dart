import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize local notifications
  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Specify the app icon

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show a notification when a message is received
  void showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Customize this channel ID
      'your_channel_name', // Customize the channel name
      channelDescription: 'your_channel_description', // Optional
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? 'Default Title', // Title from Firebase
      message.notification?.body ?? 'Default Body', // Body from Firebase
      platformChannelSpecifics,
      payload: 'Notification Payload', // Optional
    );
  }

  // Method to get FCM token
  Future<String?> token() async {
    try {
      String? deviceToken = await messaging.getToken();
      print("FCM Device Token: $deviceToken");
      return deviceToken;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  // **Add this method to show a local notification with custom title and body**
  Future<void> showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Customize this channel ID
      'your_channel_name', // Customize the channel name
      channelDescription: 'your_channel_description', // Optional
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Custom title
      body,  // Custom body
      platformChannelSpecifics,
      payload: 'Notification Payload', // Optional
    );
  }
}
