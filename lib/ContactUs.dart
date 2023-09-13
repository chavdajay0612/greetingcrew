import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

void launchUrl2() async{
  var url = 'https://www.facebook.com/';
  if (await canLaunch(url)) {
    await launch( url, universalLinksOnly: true, );
  } else { throw 'There was a problem to open the url: $url'; }

}

class ContactUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us',
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate logo size based on screen width
    double logoSize = screenSize.width * 0.2; // You can adjust the factor as needed

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Contact Us'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: contact@greetingcrew.com'),
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone: +91 7575807929'),
              ),
              ListTile(  // Add this ListTile for the website link
                leading: const Icon(Icons.public),
                title: const Text('Website: www.example.com'),  // Replace with your website URL
                onTap: () {
                  launch('https://www.example.com');  // Replace with your website URL
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}