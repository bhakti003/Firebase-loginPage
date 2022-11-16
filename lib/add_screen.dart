
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/display_screen.dart';
import 'package:loginpage/usermodel.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController pricesController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var imageshow;
  var item;
  var itemList = ['Crispy Baked Falafel','Veggie Tomato Mix','item1','item2',];

  get userData => null;

  @override
  @override
  // void initState() {
  //   getUserData();
  //   super.initState();
  // }
  getUserData() async {
    var userDataFirebase = await FirebaseFirestore.instance
        .collection('Login')
        .get();
    // print("USERDATA${userDataFirebase.}");
    userDataFirebase.docs
        .map((e) => userData.add(UserModel.fromJson(e.data())))
        .toList();
    // print("USERDATA${userData[1].uid}");
    setState(() {
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(children: [
          SizedBox(height: 3.h),
          Center(
              child: CircleAvatar(
                radius: 8.h,
                child: ClipOval(
                  child: imageshow != null
                        ? Image.file(File(imageshow),fit: BoxFit.fill,width: 33.w,height: 20.h,)
                        :GestureDetector(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          imageshow = image!.path;
                          print("imageshow ${imageshow}");
                        });
                      },
                      child: Center(child: Icon(Icons.camera_alt))),
                ),
              )
          ),
          SizedBox(height: 3.h,),

          SizedBox(width: 95.w,
            child: DropdownButton(
              items: itemList.map((value) => DropdownMenuItem<String>(value : value,
                  child: Text(value))).toList(),value: item != null ? item : null,
              onChanged: (value){
                item =value;
                setState(() {
                });
              },
              // decoration: InputDecoration(
              //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // ),
              // dropdownColor: Colors.black38.withOpacity(0.2),
              elevation: 20,
                hint: Text("   Enter some item"),
                icon: Icon(Icons.keyboard_arrow_down),
                isExpanded: false,

            ),
          ),
          SizedBox(height: 3.h,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: pricesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Prices',
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          GestureDetector(onTap: (){
            getUserData();
            Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayScreen(),));
          },
            child: Container(
              height: 8.h,
              width: 33.w,
              color: Colors.grey,
              child: Center(child: Text("ADD",style: TextStyle(fontSize: 20),)),
            ),
          )

        ],
        ),
      ),
    );
  }
}
