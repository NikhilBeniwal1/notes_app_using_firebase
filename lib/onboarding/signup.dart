import 'package:cloud_firestore/cloud_firestore.dart';
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
  var _nameControler = TextEditingController();

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
            controller: _nameControler,
            decoration: InputDecoration(
              labelText: 'name',
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

              onPressed: () async {
                var auth = FirebaseAuth.instance;
                var firestore = FirebaseFirestore.instance;

                try{
                var usercred = await auth.createUserWithEmailAndPassword(email: _emailControler.text, password: _passControler.text);

                var uuid = usercred.user!.uid;
                 var createdAt = DateTime.now().microsecondsSinceEpoch;

                 firestore.collection("users").doc(uuid).set({
                   "emial": usercred.user!.email,
                   "name" : _nameControler.text,
                   "pass": _passControler.text ,
                   "createdAt" : createdAt,
                 });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account created login now")));

                } on FirebaseAuthException catch (e){
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));

                  }
                } catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : $e")));

                }

              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade400),foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: Text("    Create Account   ")
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
                    Navigator.pop(context);
                  },
                  child: Text("Login now",style: TextStyle(color: Colors.cyan),)),

            ],),
          )

        ],),
      ),
    );
  }
}
