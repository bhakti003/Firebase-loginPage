import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpage/login_page.dart';
import 'package:loginpage/sign_up.dart';
import 'package:loginpage/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  //UserModel? user;
  FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var userData=<UserModel>[];
  // setData() async {
  //   final pref = await SharedPreferences.getInstance();
  //   pref.setBool('isLogin', false);
  // }
  // clear() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.clear();
  // }

  @override
  void initState() {
    getUserData();
    super.initState();
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(onTap: (){
                  FirebaseAuth.instance.signOut().then((value) => {
                  print("Signed Out"),
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),))
                  });
              },
                child: Container(
                      child: Center(child: Text('Log Out')),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 300,
                child: ListView.separated(itemBuilder: (context,index){
                  return Card(
                    child:ListTile(
                    onTap: (){},
                      title: Column(
                        children: [
                          Text(userData[index].email!),
                          Text(userData[index].uid!)
                        ],
                      ),
                    ) ,
                  );
                }, separatorBuilder: (context,index){return SizedBox(height: 10,);}, itemCount: userData.length),
              ),
           ]
                ),
              ),
      )
            // Container(
            //   height: 200,
            //   width: 300,
            //   decoration: BoxDecoration(
            //     color: Colors.white.withOpacity(0.3),
            //   ),
            //   child: Center(child: Text('${userData[1].email}',style: TextStyle(fontSize: 30),)),
            // ),
            // GestureDetector(onTap: (){
            //   FirebaseAuth.instance.signOut().then((value) => {
            //   print("Signed Out"),
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),))
            //   });
            // },
            //   child: Container(
            //     width: 80,
            //     height: 40,
            //     color: Colors.black38,
            //     child: Center(child: Text('Log Out')),
            //   ),
            //
    );
  }
}
