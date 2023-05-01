import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testproj/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:testproj/screens/post_page.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getLoading() {
    return isLoading;
  }

  Timer? _timer;
  FirebaseAuth _auth = FirebaseAuth.instance;
  isLogin(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.currentUser != null
        ? Timer(
            Duration(seconds: 3),
            () => Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => PostPage()),
            ),
          )
        : Timer(
            Duration(seconds: 3),
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<LoginProvider>(
                  create: (_) => LoginProvider(),
                  child: LoginScreen(),
                ),
              ),
            ),
          );
  }
}
