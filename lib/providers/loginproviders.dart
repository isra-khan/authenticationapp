import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testproj/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:testproj/screens/post_page.dart';
import 'package:testproj/utils/utils.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getLoading() {
    return isLoading;
  }

  Timer? _timer;

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

  authCheck(String email, String password, BuildContext context) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //  setState(() {
      // isLoading = false;
      setIsLoading(false);
      // });]

      Utils().message(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostPage()));
    }).onError((error, stackTrace) {
      //setState(() {
      // isLoading = false;
      setIsLoading(false);
      // });
      Utils().message(error.toString());
      notifyListeners();
    });
  }

  void signUp(String email, String password, BuildContext context) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //setState(() {

      //loading = false;
      setIsLoading(false);
      // });
    }).onError((error, stackTrace) {
      Utils().message(error.toString());
      //  setState(() {
      // loading = false;
      setIsLoading(false);
      notifyListeners();
      //  });
    });
  }
}
