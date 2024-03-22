import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_app/auth/screeen/otp.dart';
import 'package:testing_app/util/error.dart';
import 'package:testing_app/util/snackbar.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
    required String confirmpass,
  }) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (password != confirmpass) {
        throw Exception("Passwords do not match");
      }

      http.Response res = await http.post(
        Uri.parse('https://pankhay.com/thewhitehousegame/public/api/register'),
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": confirmpass
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      // // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showCustomSnackBar(
            context,
            'Account created! We send your password on your typed email',
          );
        },
      );
    } catch (e) {
      showCustomSnackBar(
        context,
        e.toString(),
      );
    }
  }

  // // sign in user
  // void signInUser({
  //   required BuildContext context,
  //   required String email,
  //   required String password,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('https://pankhay.com/thewhitehousegame/public/api/login'),
  //       body: jsonEncode({
  //         'email': email,
  //         'password': password.toString(),
  //       }),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(res.body);
  //     // // ignore: use_build_context_synchronously
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () async {
  //           await prefs.setString(
  //               'x-auth-token', jsonDecode(res.body)['token']);

  //           // Navigator.pushNamedAndRemoveUntil(
  //           //   context,
  //           //   Homepage.id,
  //           //   (route) => false,
  //           // );
  //         });
  //   } catch (e) {
  //     showCustomSnackBar(context, e.toString());
  //   }
  // }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://pankhay.com/thewhitehousegame/public/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200) {
        final responseData = jsonDecode(response.body);

        // Save token to SharedPreferences

        // Check if email is verified
        if (responseData.containsKey('error') &&
            responseData['error'] == 'Unauthorized: Email not verified.') {
          // Email not verified, navigate to the OTP verification screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerificationScreen(),
            ),
          );
        } else {
          // Email verified, navigate to the home screen
          // Replace 'HomeScreen' with the actual name of your home screen
          // Navigator.pushNamed(context, 'HomeScreen');
        }
      } else {
        // Handle other status codes (e.g., server error)
        throw Exception('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions (e.g., network errors)
      showCustomSnackBar(context, e.toString());
    }
  }
}
