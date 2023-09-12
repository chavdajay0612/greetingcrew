import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:greetingcrew/Home.dart';
import 'package:greetingcrew/dtschedule.dart';



// ignore: camel_case_types
class template extends StatelessWidget {
  const template({super.key});

  @override
  Widget build(BuildContext context) {
    return  const FileUploadScreen();
  }
}

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  bool option1Selected = false;
  bool option2Selected = false;
  List<File> selectedFiles = [];
  List<String> fileNames = [];

  Future<void> uploadFilesToFirebase() async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    print("userid ==>>$userId");
    final DatabaseReference userRef = FirebaseDatabase.instance.reference().child('files').child(userId!); // Replace 'user_id' with the actual user's UID

    for (var i = 0; i < selectedFiles.length; i++) {
      final file = selectedFiles[i];
      final fileName = 'file_${i}.${file.path.split('.').last}';
      print("fileName ==>>$fileName");
      final fileRef = storageRef.child(fileName);

      await fileRef.putFile(file);
      fileNames.add(fileName);
      await userRef.push().set({
        'option1Selected': option1Selected,
        'option2Selected': option2Selected,
        'fileName': fileName,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Files uploaded')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => dtschedule(PhoneNumber: '',)),
    );
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: option2Selected,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.black,
        title: const Text('Template'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
              title: const Text('Birthday'),
              value: option1Selected,
              onChanged: (bool? value) {
                setState(() {
                  option1Selected = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Anniversary'),
              value: option2Selected,
              onChanged: (bool? value) {
                setState(() {
                  option2Selected = value!;
                });
              },
            ),
            option2Selected && option1Selected
                ? Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: pickFiles,
                  child: const Text('Select File 1'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Set the background color to black
                  ),
                ),
                ElevatedButton(
                  onPressed: pickFiles,
                  child: const Text('Select File 2'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Set the background color to white
                    onPrimary: Colors.black, // Set the text color to black
                  ),
                )
              ],
            ):
            // option2Selected || option1Selected
            // ?ElevatedButton(
            //   onPressed: pickFiles,
            //   child: Text('Select File'),
            // ):
            option2Selected || option1Selected
                ? Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: pickFiles,
                  child: const Text('Select File'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Set the background color to black
                  ),
                ),
              ],
            ):
            ElevatedButton(
              onPressed: () {  },
              child: const Text('Please Select Option'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Set the background color to black
              ),
            ),
            ElevatedButton(
              onPressed: uploadFilesToFirebase,
              child: const Text('Send'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,// Set the background color to black
              ),
            ),
          ],
        ),
      ),
    );
  }
}