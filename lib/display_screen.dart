

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/usermodel.dart';
import 'package:sizer/sizer.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var userData = <UserModel>[];
  @override
  void initState() {
    // setUserData();
    super.initState();
  }
  @override
  // setUserData() async {
  //   var userDataFirebase = await FirebaseFirestore.instance
  //       .collection('Login')
  //       .set(userData);
  //   // print("USERDATA${userDataFirebase.}");
  //   userDataFirebase.docs
  //       .map((e) => userData.add(UserModel.fromJson(e.data())))
  //       .toList();
  //   // print("USERDATA${userData[1].uid}");
  //   setState(() {
  //   });
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(children: [
          SizedBox(height: 3.h),
          Center(
              child: CircleAvatar(
                radius: 8.h,
              )
          ),
          SizedBox(height: 3.h,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // SizedBox(height: 3.h,),
          // Container(
          //   height: 8.h,
          //   width: 33.w,
          //   color: Colors.grey,
          //   child: Center(child: Text("ADD",style: TextStyle(fontSize: 20),)),
          // )

        ],
        ),
      ),
    );
  }
}
