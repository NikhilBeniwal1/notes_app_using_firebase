import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
 String mverificationID;
 OtpScreen({super.key, required this.mverificationID });


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otp1Controller = TextEditingController();
  var otp2Controller = TextEditingController();
  var otp3Controller = TextEditingController();
  var otp4Controller = TextEditingController();
  var otp5Controller = TextEditingController();
  var otp6Controller = TextEditingController();
 // var _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(height: 180,),

          Center(child: Text("Verification code has been sent",style: TextStyle(fontSize: 30),)),
          Center(child: Text(" ****** ",style: TextStyle(fontSize: 20),)),

          SizedBox(height: 40,),


        /*  ///Verify OTP
           SizedBox( width: MediaQuery.of(context).size.width *0.7 ,child: TextField(
            controller: _otpControler,
            decoration: InputDecoration(
              labelText: 'Enter Otp',
              border: OutlineInputBorder(),
            ),
          ),),
          SizedBox(height: 20,),*/


          /// verify otp with multi text fields
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myTextField(controller: otp1Controller, mFocus: true),
              myTextField(controller: otp2Controller, mFocus: true),
              myTextField(controller: otp3Controller, mFocus: true),
              myTextField(controller: otp4Controller, mFocus: true),
              myTextField(controller: otp5Controller, mFocus: true),
              myTextField(controller: otp6Controller, mFocus: true),
            ],
          ),
          SizedBox(height: 30,),


          ElevatedButton(onPressed: () async {
   if(otp1Controller.text.isNotEmpty &&
       otp2Controller.text.isNotEmpty &&
       otp3Controller.text.isNotEmpty &&
       otp4Controller.text.isNotEmpty &&
       otp5Controller.text.isNotEmpty &&
       otp6Controller.text.isNotEmpty
   ) { try{
     var auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
    verificationId: widget.mverificationID,
    smsCode: "${otp1Controller.text.toString()}${otp2Controller.text.toString()}${otp3Controller.text.toString()}${otp4Controller.text.toString()}${otp5Controller.text.toString()}${otp6Controller.text.toString()}");
 var userCred = await auth.signInWithCredential(credential);
var pref = await SharedPreferences.getInstance();
pref.setString("userId", userCred.user!.uid);
Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context)
    => HomeScreen(userID: userCred.user!.uid),));
    } catch (ex){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ops Error : $ex")));
    }
    }
          }, child: Text("Verify OTP",style: TextStyle(color: Colors.green),))

        ],),
      ),
    );
  }

  Widget myTextField(
      {required TextEditingController controller, required bool mFocus}) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        maxLength: 1,
        textAlign: TextAlign.center,
        autofocus: mFocus,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }


}


/////
