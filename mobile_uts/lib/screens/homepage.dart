import 'package:flutter/material.dart';
import 'package:mobile_uts/screens/list_product.dart';
import 'package:mobile_uts/screens/list_users.dart';
import 'package:mobile_uts/screens/login.dart';
import 'package:mobile_uts/screens/splash.dart';

class HomePage extends StatelessWidget {
  final String dataName;

  const HomePage({Key? key, required this.dataName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'http://10.0.2.2:8000/img/product1713683106.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 30),
            Text(
              'Selamat Datang $dataName',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListProduct()));
              },
              child: Text(
                'View Products',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListUser()));
              },
              child: Text(
                'View Users',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Splash()),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Terima kasih sudah berkunjung'),
                  duration: Duration(seconds: 3), // Atur durasi snackbar
                ));
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.yellow,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
