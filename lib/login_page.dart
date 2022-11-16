import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpage/add_screen.dart';
import 'package:loginpage/sign_up.dart';
import 'package:loginpage/usermodel.dart';

import 'homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  UserModel? data;
  LoginPage({Key? key, this.data}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool? isLogin;
  bool? newuser;
  @override
  void initState() {
    // getBool();
    super.initState();
  }
  // getBool() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   newuser =  pref.getBool('login')?? true;
  //   if(newuser==false)
  //   {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(),));
  //   }
  // }
  // setBool() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool('login',false);
  // }



  login() async {
    try {
      final firebaseauth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddScreen(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 13.sp),
        )));
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'Wrong password provided for that user.',
            style: TextStyle(fontSize: 13.sp),
          )),
        );
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 50, left: 20),
                    height: 10.h,
                    width: 20.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIlJr3bkOJgguI2XKfGe-rVgppvpTTJnnv8_gK1zoWgiLQPLm6k5qpz7_F1ddqh8Fb9d4&usqp=CAU"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Enter Email';
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      } else if (value.length < 6) {
                        return "Password must be atleast 6 characters long";
                      } else if (value != passController.text) {
                        return "Password must be same as above";
                      } else {
                        return null;
                      }
                    },
                    controller: passController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 8.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Color(0xff03087b).withOpacity(0.3)),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              // set();
                              // setBool();
                              login();
                              setState(() {

                              });
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Color(0xff03087b),
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Need an account?',
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff03087b),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: Container(
                        height: 7.h,
                        width: 6.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/google.png'))),
                      ),
                    ),
                    // Container(
                    //   height: 7.h,
                    //   width: 6.w,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(image: AssetImage('assets/facebook.png')),
                    //   ),
                    // )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
