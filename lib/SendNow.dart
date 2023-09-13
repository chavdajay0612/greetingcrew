import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/src/material/date_picker_theme.dart';

import 'Data.dart';

class SendNOW extends StatefulWidget {
  @override
  _SendNOW createState() => _SendNOW();
}

class _SendNOW extends State<SendNOW> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  String _selectedDateTime = '';



  void _sendWhatsAppMessage() async {
    String phoneNumber = _phoneNumberController.text;
    String message = _messageController.text;
    var whatsappURl_android = "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";
    await launchUrl(Uri.parse(whatsappURl_android));
    String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Message Scheduler'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Enter Receiver Mobile No'),
              SizedBox(height: 20),
              SizedBox(height: 25,),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Phone Number',
                  hintText: 'Phone number',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Iconsax.call, color: Colors.black, size: 18, ),
                  suffixIcon: GestureDetector(
                    onTap: (){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen() ));

                    }, // Navigate to contacts page
                    child: Icon(Icons.person, color: Colors.black, size: 26, ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Message',
                  hintText: 'Message',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Iconsax.message, color: Colors.black, size: 18, ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 20),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: _sendWhatsAppMessage,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  "Send Message via Whatsapp",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
