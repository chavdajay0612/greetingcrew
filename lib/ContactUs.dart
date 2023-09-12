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
        title: Text('Contact Us'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Padding(
          padding: EdgeInsets.only(bottom: 80.0), // Add margin at the bottom
          child: Container(
          height: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/logo2.jpeg"),
            ),
            ),
          ),
        ),
              Text(
                'Contact Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: contact@example.com'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone: +91 123-456-7890'),
              ),
              ListTile(  // Add this ListTile for the website link
                leading: Icon(Icons.public),
                title: Text('Website: www.example.com'),  // Replace with your website URL
                onTap: () {
                  launch('https://www.example.com');  // Replace with your website URL
                },
              ),
              SizedBox(height: 16),
              Text(
                'Connect with Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: IconButton(
                      icon: Container(
                        child: Image.asset('assets/Face.jpg'), // Replace with your Facebook logo image asset
                      ),
                      onPressed: () {
                        launchUrl2();
                        launch('https://www.facebook.com/your_facebook_page');// Add your Facebook link here
                      },
                    ),
                  ),
                  SizedBox(
                    width: 65,
                    height: 65,
                  child: IconButton(
                    icon: Container(
                      child: Image.asset('assets/Lin.jpg'), // Replace with your Google logo image asset
                    ),
                    onPressed: () {
                      launch('https://www.linkedin.com');
                      //Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));

                    },
                  ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: IconButton(
                      icon: Container(
                        child: Image.asset('assets/X.jpg'), // Replace with your Google logo image asset
                      ),
                      onPressed: () {
                        launch('https://twitter.com');
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));

                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
