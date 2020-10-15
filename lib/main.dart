import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/screens/Settings.dart';
import 'package:dailybio/screens/bio_lists.dart';
import 'package:dailybio/services/DatabaseService.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'screens/bio_pages.dart';
import 'package:dailybio/screens/AuthScreens/login_screen.dart';
import 'package:dailybio/screens/AuthScreens/register_screen.dart';
import 'screens/Settings.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final androidInitialize = new AndroidInitializationSettings('app_icon');
  final iosInitialize = new IOSInitializationSettings();
  final initializationSettings = new InitializationSettings(
      android: androidInitialize, iOS: iosInitialize);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'bios',
        routes: {
          'login': (context) => LoginScreen(),
          'register': (context) => RegisterScreen(),
          'bios': (context) => BioPages(),
          'bio_lists': (context) => BioLists(),
          'settings': (context) => SettingsPage(),
        },
      ),
    ),
  );
}
