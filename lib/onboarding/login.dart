import 'package:flutter/material.dart';
import 'package:notes_app_firebase/onboarding/signup.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

              onPressed: (){},
              // style: ButtonStyle(),
              child: Text("    Save    ")
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
