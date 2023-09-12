import 'package:flutter/material.dart';
import 'package:greetingcrew/ContactUs.dart';
import 'package:greetingcrew/ProfilePage.dart';
import 'package:greetingcrew/SendNow.dart';
import 'package:greetingcrew/dtschedule.dart';
import 'package:greetingcrew/template.dart';
import 'Data.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("GreetingCrew"),),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> template()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmarks_rounded,size: 50,color: Colors.white,),
                  SizedBox(height: 20,),
                  Text("Templates",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storage,size: 50,color: Colors.white,),
                  SizedBox(height: 20,),
                  Text("Data",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> dtschedule(PhoneNumber: '',)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time,size: 50,color: Colors.white,),
                  SizedBox(height: 20,),
                  Text("Schedule",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SendNOW()));
              // send now
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send_rounded,size: 50,color: Colors.white,),
                  SizedBox(height: 20,),
                  Text("Send Now",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUsPage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contacts_rounded,size: 50,color: Colors.white,),
                  SizedBox(height: 20,),
                  Text("Contact Us",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contact_mail_rounded,size: 50,color: Colors.white,),
                  SizedBox(height: 20,),
                  Text("Profile",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],),
            ),
          ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
        ),
      ),),
    );
  }
}