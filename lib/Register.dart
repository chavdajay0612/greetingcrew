import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
import 'Login.dart';
import 'main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';

class RegisterWithPhoneNumber extends StatefulWidget {
  const RegisterWithPhoneNumber({Key? key}) : super(key: key);

  @override
  _RegisterWithPhoneNumberState createState() => _RegisterWithPhoneNumberState();
}

class _RegisterWithPhoneNumberState extends State<RegisterWithPhoneNumber> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isSecurePassword = true;
  bool _isSecurePassword1 = true;
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users');

      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final String userUID = userCredential.user!.uid;

      await userRef.child(userUID).set({
        'name': nameController.text,
        'email': emailController.text,
        'Phone': phoneController.text,
      });

      var sharedpref = await SharedPreferences.getInstance();
      sharedpref.setBool(WelcomePage.KEYLOGIN, true);

      sharedpref.setString('userId', '${userCredential.user?.uid}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool isValidEmail(String input) {
    final RegExp regex = RegExp(r'^[\w-]+@([\w-]+\.)+\w{2,4}$');
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: 15),
                    FadeInDown(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey.shade900),
                      ),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                        child: Text(
                          'Enter your information to continue.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              labelText: 'Name',
                              hintText: 'Username',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Iconsax.user, color: Colors.black, size: 18, ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              labelText: 'Email',
                              hintText: 'E-mail',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Iconsax.user, color: Colors.black, size: 18, ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!isValidEmail(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            maxLength: 6,
                            cursorColor: Colors.black,
                            controller: passwordController,
                            obscureText: _isSecurePassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              labelText: 'Password',
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: const Icon(Iconsax.key, color: Colors.black, size: 18, ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: togglePassword(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            maxLength: 6,
                            cursorColor: Colors.black,
                            controller: confirmPasswordController,
                            obscureText: _isSecurePassword1,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              labelText: 'Confirm Password',
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: const Icon(Iconsax.key, color: Colors.black, size: 18, ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: togglePassword1(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password is required';
                              } else if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              labelText: 'Phone Number',
                              hintText: 'Phone number',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: const Icon(Iconsax.call, color: Colors.black, size: 18, ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              if (value.length != 10){
                                return 'Enter Valid mobile number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25,),
                          _isLoading
                              ? CircularProgressIndicator(  color: Colors.black,)  // Show loading indicator when _isLoading is true
                              : MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                                _register();
                              }
                            },
                            height: 45,
                            color: Colors.black,
                            child: const Text("Register", style: TextStyle(color: Colors.white, fontSize: 16.0)),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?', style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0, fontWeight: FontWeight.w400)),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                },
                                child: const Text('Login', style: TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility_off, color: Colors.black)
          : const Icon(Icons.visibility, color: Colors.black),
    );
  }

  Widget togglePassword1() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword1= !_isSecurePassword1;
        });
      },
      icon: _isSecurePassword1
          ? const Icon(Icons.visibility_off, color: Colors.black)
          : const Icon(Icons.visibility, color: Colors.black),
    );
  }
}