import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_app/auth/screeen/home.dart';
import 'package:testing_app/auth/screeen/login.dart';
import 'package:testing_app/auth/services.dart/authServices.dart';
import 'package:testing_app/auth/widget/Customtextfeild.dart';
import 'package:testing_app/auth/widget/customButton.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Register extends StatefulWidget {
  static const String id = '/Register';

  @override
  State<Register> createState() => _RegisterState();
}

final AuthService auth = AuthService();
bool isCheckboxChecked = false;

class _RegisterState extends State<Register> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    // Check if registration is successful
    initializeNotifications();
    checkRegistrationStatus();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void checkRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if a token is stored in SharedPreferences
    bool? authToken = prefs.getBool('x-auth-token');
    if (authToken == true) {
      // Token found, delay for 2 seconds then navigate to home screen
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }
  }

  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpass = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    fullname.dispose();
    password.dispose();
    confirmpass.dispose();
  }

  void usersignup() {
    auth.signUpUser(
        context: context,
        email: email.text,
        name: fullname.text,
        password: password.text.toString(),
        confirmpass: confirmpass.text.toString());
    showNotification();
  }

  void showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Registration Successful',
      'Your account has been created successfully',
      platformChannelSpecifics,
    );
  }

  String? passwordMatchValidator(String? value) {
    if (value != password.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF2F2F2),
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Your full name will appear only on the profile',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.4),
                ),
                const SizedBox(
                  height: 24,
                ),
                Form(
                  key: signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        is_pass: false,
                        hintText: 'Full name',
                        icon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        controller: fullname,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        hintText: 'Email',
                        controller: email,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        is_pass: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        hintText: 'Password',
                        controller: password,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        is_pass: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                        hintText: 'Confirm Password',
                        controller: confirmpass,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        is_pass: true,
                        validator: passwordMatchValidator,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Button(
                        onPressed: () {
                          if (signUpFormKey.currentState!.validate()) {
                            usersignup();
                          }
                        },
                        minimumSize: const Size(double.maxFinite, 64),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF999999)),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.zero)),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                        email.clear();
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            color: Color(0xFF4C2000)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
