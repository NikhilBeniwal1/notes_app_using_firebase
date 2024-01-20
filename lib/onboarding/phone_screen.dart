import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/onboarding/otpscreen.dart';

class EnterPhoneNO extends StatefulWidget {
  @override
  State<EnterPhoneNO> createState() => _EnterPhoneNOState();
}

class _EnterPhoneNOState extends State<EnterPhoneNO> {
late String mVerificationID;

  TextEditingController  _phoneControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with mobile no"),
      centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey.shade100,
      body:  /// Send OTP
      Container(child: Column(children: [
        SizedBox(height: 180,),

        Center(child: Text("Enter your mobile Number",style: TextStyle(fontSize: 30),)),
        SizedBox(height: 10,),
        Center(child: Text("you will receive a 6 digits Otp to verify next",style: TextStyle(fontSize: 16),)),
        SizedBox(height: 10,),

        Center(
          child: SizedBox( width: MediaQuery.of(context).size.width *0.80 ,
            child: TextField(

              controller: _phoneControler,
              decoration: InputDecoration(
               prefix: Text("+91") ,
               labelText: 'Enter Mobile no',
                border: OutlineInputBorder(),
              ),
            ),),
        ),
        SizedBox(height: 10,),

        ElevatedButton(onPressed: () async {
          await FirebaseAuth.instance.verifyPhoneNumber(
            verificationCompleted: (PhoneAuthCredential credential){},
            verificationFailed: (FirebaseAuthException ex){ },
            codeSent: (String verificationid, int? tockenId){
              mVerificationID = verificationid;
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  return OtpScreen(mverificationID: mVerificationID);
},));
            },
            codeAutoRetrievalTimeout: (String verificationId){},
            phoneNumber: "+91${_phoneControler.text.toString()}",
          );
        }, child: Text("Send OTP."))
      ],),),
    );
  }
}
