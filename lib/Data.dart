import 'dart:math';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dtschedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactPermission();
  }

  Future<void> getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
      // Fluttertoast.showToast(msg: 'test1');
    } else {
      await Permission.contacts.request();
    }
  }

  Future<void> fetchContacts() async {
    // Fluttertoast.showToast(msg: 'test2');
    contacts = await ContactsService.getContacts();


    // Fluttertoast.showToast(msg: 'test3');

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contacts"),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: (){


                contacts[index].phones!.length > 0 ? Navigator.push(context, MaterialPageRoute(builder: (context) => dtschedule(PhoneNumber: "${contacts[index].phones![0].value!}",))):Fluttertoast.showToast(msg: "No Contact For This Person");

              },
              child:ListTile(
                leading: Container(
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                        color: Colors.white.withOpacity(0.1),
                        offset: const Offset(-3, -3),
                      ),
                      BoxShadow(
                        blurRadius: 7,
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(3, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xff262626),
                  ),
                  child: Text(
                    contacts[index].givenName![0],
                    style: TextStyle(
                      color: Colors.primaries[
                      Random().nextInt(Colors.primaries.length)],
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                title: Text(
                  contacts[index].givenName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle:contacts[index].phones!.length > 0 ? Text(
                  "${contacts[index].phones![0].value!}",
                  style: TextStyle(
                    color: const Color(0xffC4c4c4),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ):Text(
                  "No Contact",
                  style: TextStyle(
                    color: const Color(0xffC4c4c4),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ));
        },
      ),
    );
  }
}