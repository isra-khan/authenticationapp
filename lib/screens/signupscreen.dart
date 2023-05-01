import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:testproj/providers/loginproviders.dart';
import 'package:testproj/utils/utils.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text("Sign Up"),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<LoginProvider>(builder: (context, prov, _) {
                  return InkWell(
                    onTap: () {
                      prov.setIsLoading(true);
                      // loading = true;
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {
                          //   setState(() {

                          // loading = true;
                          prov.setIsLoading(true);
                          // });
                          if (_formkey.currentState!.validate()) {
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password:
                                        _passwordController.text.toString())
                                .then((value) {
                              //setState(() {

                              //loading = false;
                              prov.setIsLoading(false);
                              // });
                            }).onError((error, stackTrace) {
                              Utils().message(error.toString());
                              //  setState(() {
                              // loading = false;
                              prov.setIsLoading(false);
                              //  });
                            });
                          }
                        },
                        child: prov.getLoading()
                            ? CircularProgressIndicator(
                                color: Colors.black45,
                              )
                            : Text("sign up"),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
