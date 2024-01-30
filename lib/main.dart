import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app_firebase/screens/splashscreen.dart';
import 'firebase_options.dart';
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }

 /*Future<Widget> checkLogin()async{
   var auth = FirebaseAuth.instance;

   var pref = await SharedPreferences.getInstance();
   var  checkLogin = pref.getBool(LoginPage.LOGIN_PREF_KEY);
    if(checkLogin==null){
      return LoginPage();
    } else if (checkLogin){
      return HomeScreen(userID: auth.currentUser!.uid);
    }else {
      return Container();
    }
 }*/

}
