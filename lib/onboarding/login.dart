import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
   prefs.setBool(LOGIN_PREF_KEY, true);

                  } on FirebaseAuthException catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error occord : $e")));

                 /* if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));

                  }*/
                } catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : $e")));

                }
                },
               style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade400),foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: Text("      Login Now       ")
          ),
SizedBox(height: 20,),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
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
