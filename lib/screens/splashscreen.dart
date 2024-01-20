import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/login.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async{
      var auth = FirebaseAuth.instance;
      var prefs = await SharedPreferences.getInstance();

      bool? checkLogin = prefs.getBool(LoginPage.LOGIN_PREF_KEY);

      String? checkPhoneAuth = prefs.getString("userId");
      Widget navigateTO = LoginPage();


      if(checkLogin!=null && checkLogin){
        print("$checkLogin 555..");

        navigateTO = HomeScreen(userID: auth.currentUser!.uid);
      }
      if(checkPhoneAuth!.isNotEmpty){

        navigateTO = HomeScreen(userID: auth.currentUser!.uid);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => navigateTO,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notes,
              size: 34,
              color: Colors.white,
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              "Notes app using firebase",
              style: TextStyle(fontSize: 25, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}