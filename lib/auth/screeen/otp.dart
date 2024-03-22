import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_app/auth/screeen/home.dart';

class OTPVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to your email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            PinInputTextField(
              pinLength: 4,
              keyboardType: TextInputType.number,
              decoration: UnderlineDecoration(
                colorBuilder: FixedColorBuilder(Colors.black),
              ),
              controller: TextEditingController(),
              autoFocus: true,
              textInputAction: TextInputAction.done,
              enabled: true,
              onChanged: (pin) {
                // You can implement logic here to handle OTP changes if needed
              },
              onSubmit: (pin) async {
                // Implement logic to verify OTP
                if (pin == '1234') {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('x-auth-token', true);
                  // OTP is correct, you can navigate to the next screen
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  // OTP is incorrect, display an error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Invalid OTP'),
                      content: Text('Please enter the correct OTP.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            // CustomButton( // Replace CustomButton with your custom button widget
            //   onPressed: () {
            //     // This is optional, you can remove this button if not needed
            //   },
            //   child: Text('Resend OTP'),
            // ),
          ],
        ),
      ),
    );
  }
}
