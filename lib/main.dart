import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testproj/providers/loginproviders.dart';
import 'package:testproj/screens/splashscreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();
  runApp(MaterialApp(
      home: Provider<LoginProvider>(
    create: (_) => LoginProvider(),
    child: SplashScreen(),
  )));
}
