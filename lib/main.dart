import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
import 'login.dart';
import 'Register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WHERETOGOCLASS(),
  ));
}

class WHERETOGOCLASS extends StatefulWidget {
  const WHERETOGOCLASS({super.key});

  @override
  State<WHERETOGOCLASS> createState() => _WHERETOGOCLASSState();
}

class _WHERETOGOCLASSState extends State<WHERETOGOCLASS> {

  void initState(){
    super.initState();
    whereToGo();
  }

  Future<void> whereToGo() async{
    var sharedpref= await SharedPreferences.getInstance();

    var isloggedin = sharedpref.getBool(WelcomePage.KEYLOGIN);

    if (isloggedin!=null){
      if(isloggedin){
        // Fluttertoast.showToast(msg: 'hello is logged');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyHomePage(),));
      }else{

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomePage(),));
      }
    }else{
      // Fluttertoast.showToast(msg: 'hello null ecxcp');

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WelcomePage(),));
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


class WelcomePage extends StatefulWidget {
  static const String KEYLOGIN = "Login";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // we will give media query height
            // double.infinity make it big as my parent allows
            // while MediaQuery make it big as per the screen

            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,

                      ),

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("BackSlash Flutter provides extraordinary flutter tutorials. Do Subscribe! ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,

                      ),)
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo-png.png")

                      )
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/w.png")

                      )
                  ),
                ),

                Column(
                  children: <Widget>[
                    // the login button
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));

                      },
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    ),
                    // creating the signup button
                    const SizedBox(height:20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RegisterWithPhoneNumber()));

                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
