import 'dart:io'; // Import the 'dart:io' library for File operations
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'Support.dart';
import 'TermsAndServices.dart';
import 'main.dart';


class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Define a variable to store the selected image
  XFile? _image;
  bool messageNotificationsEnabled = true;


  // Function to open the image picker
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Image and Edit Symbol
            // Profile Image and Edit Symbol
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: _image != null ? FileImage(File(_image!.path)) : null,
                    backgroundColor: Colors.black, // Background color for empty profile image
                    child: _image == null
                        ? const Icon(Icons.camera_alt, size: 40.0, color: Colors.white)
                    // Camera icon for empty image

                        : Container(
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Edit Profile Section
            const SizedBox(height: 24.0),
            const Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              cursorColor: Colors.black,
              //controller: emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'First Name',
                hintText: 'First Name',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Iconsax.user, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),

            ),
            const SizedBox(height: 15,),
            TextField(
              cursorColor: Colors.black,
              //controller: emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Last Name',
                hintText: 'Last Name',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Iconsax.user, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            const SizedBox(height: 15,),
            TextField(
              cursorColor: Colors.black,
              //controller: emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Mobile Number',
                hintText: 'Mobile Number',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Iconsax.call, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap:(){

                  // Work For Saving

                },
                child:Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(9)
                  ),
                  child: const Center(child: Text("SAVE",style: TextStyle(color: Colors.white),),),
                ),),
            ),
            const SizedBox(height: 20,),
            SwitchListTile(
              title: const Text('Message Notifications'),
              value: messageNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  messageNotificationsEnabled = value;
                  // Implement your logic for enabling/disabling message notifications here
                });
              },
            ),


            // App Settings Section
            const SizedBox(height: 24.0),
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Iconsax.support, color: Colors.black),
              title: const Text('Support'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SupportPage()));
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.security, color: Colors.black),
              title: const Text('Terms of Service'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndServicesPage()));
              },
            ),
            TextButton(
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 25,color: Colors.black),
              ),

              onPressed: ()  async{
                var sharedpref=await SharedPreferences.getInstance();
                sharedpref.setBool(WelcomePage.KEYLOGIN, false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
