import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/onboarding/login.dart';

import '../custom_widgets/custom_elevatedbutton.dart';
import '../custom_widgets/custom_textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _emailControler = TextEditingController();
  var _passControler = TextEditingController();
  var _nameControler = TextEditingController();
  var  _phoneControler = TextEditingController();
  late String mVerificationID;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Text("create Account",style: TextStyle(fontSize: 30),),
          SizedBox(height: 20,),
          /// email
          CustomTextFormField(controller: _emailControler, hintText: "Enter your email", lableText: "Email", validatorText: "pls enter valid input" ,suffixIcon: Icon(Icons.email),),

          SizedBox(height: 20,),
/// Name
          CustomTextFormField(controller: _nameControler, hintText: "Enter your name", lableText: "Name", validatorText: "pls enter valid input" ,suffixIcon: Icon(Icons.account_circle),),

          SizedBox(height: 20,),
          /// password
          CustomTextFormField(controller: _passControler, hintText: "Enter password", lableText: "Password", validatorText: "pls enter valid input" ,suffixIcon: Icon(Icons.password),obscureText: true,),

          SizedBox(height: 20,),

          /// Enter mobile no
          CustomTextFormField(controller: _phoneControler, hintText: "Enter Mobile no", lableText: "Mobile no", validatorText: "pls enter valid input" ,suffixIcon: Icon(Icons.phone_android),prefix: Text("+91 "),),





          SizedBox(height: 20,),
/// create account button
          CustomElevatedButton( onPressed: () async {
            if(
            _emailControler.text.isNotEmpty &&
                _nameControler.text.isNotEmpty &&
                _phoneControler.text.isNotEmpty &&
                _passControler.text.isNotEmpty
            ){  var auth = FirebaseAuth.instance;
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
                "mobile" : "+91${_phoneControler.text}",
              });
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pls enter valid input")));
            }
          }, buttonText: "Create Account",textcolor: Colors.white,width: 180,height: 36,borderRadius: 30),
SizedBox(height: 10,),
          Divider(),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Allready have an account ? "),
              InkWell(
                  onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                   return  LoginPage();
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
