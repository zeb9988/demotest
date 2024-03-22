import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logout logic here
                // For example, clear user authentication token and navigate back to the login screen
                // Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
