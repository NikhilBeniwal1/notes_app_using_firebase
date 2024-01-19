import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
TextEditingController  _phoneControler = TextEditingController();
TextEditingController  _otpControler = TextEditingController();
late String mVerificationID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(height: 180,),

          Center(child: Text("Verify your mobile number",style: TextStyle(fontSize: 30),)),

          SizedBox(height: 100,),

          /// Send OTP
          Container(child: Row(children: [
            SizedBox( width: MediaQuery.of(context).size.width *0.70 ,
                child: TextField(
                 controller: _phoneControler,
                  decoration: InputDecoration(
                    labelText: 'Enter Mobile no',
                    border: OutlineInputBorder(),
                  ),
                ),),
          SizedBox(width: 10,),

            ElevatedButton(onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                verificationCompleted: (PhoneAuthCredential credential){},
                verificationFailed: (FirebaseAuthException ex){ },
                codeSent: (String verificationid, int? tockenId){
                  mVerificationID = verificationid;

                },
                codeAutoRetrievalTimeout: (String verificationId){},
                phoneNumber: _phoneControler.text.toString(),
              );
            }, child: Text("Send OTP."))
          ],),),

          SizedBox(height: 40,),


          ///Verify OTP
          Container(child: Row(children: [
            SizedBox( width: MediaQuery.of(context).size.width *0.7 ,child: TextField(
              controller: _otpControler,
              decoration: InputDecoration(
                labelText: 'Enter Otp',
                border: OutlineInputBorder(),
              ),
            ),),
        SizedBox(width: 10,),

            ElevatedButton(onPressed: () async {
             try{
   PhoneAuthCredential credential = await PhoneAuthProvider.credential(
       verificationId: mVerificationID,
       smsCode: _otpControler.text.toString());
             } catch (ex){ }

            }, child: Text("Verify OTP",style: TextStyle(color: Colors.green),))
          ],),),

        ],),
      ),
    );
  }
}
