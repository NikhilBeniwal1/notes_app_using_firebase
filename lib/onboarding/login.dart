

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notes_app_firebase/onboarding/phone_screen.dart';
import 'package:notes_app_firebase/onboarding/signup.dart';
import 'package:notes_app_firebase/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatelessWidget {
  static const String LOGIN_PREF_KEY = "isLogin";

  var _emailControler = TextEditingController();

  var _passControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          SizedBox(height: 140,),

          Text("Hi , Wellcome back",style: TextStyle(fontSize: 30),),
          SizedBox(height: 20,),
          TextField(
            controller: _emailControler,
            decoration: InputDecoration(
              labelText: 'email',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 20,),
          TextField(
            controller: _passControler,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),

          ElevatedButton(

              onPressed: () async {
                var auth = FirebaseAuth.instance;

                try {
                  var usercred = await  auth.signInWithEmailAndPassword(
                        email: _emailControler.text,
                        password: _passControler.text);
                  /// shared pref here
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                       return HomeScreen(userID: usercred.user!.uid);
                     },));
                     // when user loged in
                     var prefs = await SharedPreferences.getInstance();

   prefs.setString("userId", usercred.user!.uid);

                  } on FirebaseAuthException catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error occord : $e")));


                } catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : $e")));

                }
                },
               style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade400),foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: Text("      Login Now       ")
          ),
SizedBox(height: 20,),
          Divider(),
          Text("Or",style: TextStyle(color: Colors.black),),

          SizedBox(height: 20,),

          InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return    EnterPhoneNO();
                },));
              },
              child: Text("You can Login with OTP",style: TextStyle(color: Colors.blue),)),

          Divider(),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("if you don't have and account  "),
              InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return SignUp();
                    },));
                  },
                  child: Text("Create Account",style: TextStyle(color: Colors.blue),)),

            ],),
          )

        ],),
      ),
    );
  }
}




////

