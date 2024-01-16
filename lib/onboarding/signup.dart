import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/onboarding/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _emailControler = TextEditingController();
  var _passControler = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Text("create Account",style: TextStyle(fontSize: 30),),
          SizedBox(height: 20,),
          TextField(
            controller: _emailControler,
            decoration: InputDecoration(
              labelText: 'email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(height: 20,),
          TextField(
            controller: _passControler,
            decoration: InputDecoration(
              labelText: 'pass',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),

          ElevatedButton(

              onPressed: (){
                var auth = FirebaseAuth.instanceFor;
                try{


                }on FirebaseAuthException catch (e){



                }

              },
              child: Text("    Save    ")
          ),

          Divider(),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("All.. have and account ? "),
              InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    },));
                  },
                  child: Text("Login now",style: TextStyle(color: Colors.cyan),)),

            ],),
          )

        ],),
      ),
    );
  }
}
