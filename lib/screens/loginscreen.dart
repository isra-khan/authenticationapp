import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testproj/screens/post_page.dart';
import 'package:testproj/providers/loginproviders.dart';
import 'package:testproj/screens/signupscreen.dart';
import 'package:testproj/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  void login() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text('Login'),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter paassword';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<LoginProvider>(builder: (context, prov, _) {
                  return InkWell(
                    onTap: () {
                      isLoading = true;
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {
                          // setState(() {
                          prov.setIsLoading(true);
                          // isLoading = true;

                          // });
                          if (_formkey.currentState!.validate()) {
                            _auth
                                .signInWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password: _passController.text.toString())
                                .then((value) {
                              //  setState(() {
                              // isLoading = false;
                              prov.setIsLoading(false);
                              // });]

                              Utils().message(value.user!.email.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage()));
                            }).onError((error, stackTrace) {
                              //setState(() {
                              // isLoading = false;
                              prov.setIsLoading(false);
                              // });
                              Utils().message(error.toString());
                            });
                          }
                        },
                        child: prov.getLoading()
                            ? CircularProgressIndicator(
                                color: Colors.black45,
                              )
                            : Text("Login"),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<LoginProvider>(
                                    create: (_) => LoginProvider(),
                                    child: SignUpScreen(),
                                  )));
                    },
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
