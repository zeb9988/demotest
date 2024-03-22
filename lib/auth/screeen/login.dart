import 'package:flutter/material.dart';
import 'package:testing_app/auth/services.dart/authServices.dart';
import 'package:testing_app/auth/widget/Customtextfeild.dart';
import 'package:testing_app/auth/widget/customButton.dart';

// Replace HomeScreen with your actual home screen widget
class Login extends StatefulWidget {
  static const String id = '/Login';

  @override
  State<Login> createState() => _LoginState();
}

final AuthService auth = AuthService();

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController email = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();
  final TextEditingController pass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  void userlogin() {
    auth.signInUser(context: context, email: email.text, password: pass.text);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Signin",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 24,
                ),
                Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: email,
                        hintText: "email",
                        is_pass: false,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        is_pass: true,
                        controller: pass,
                        hintText: "password",
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                // Navigator.pushNamed(context, ForgetPass.id);
                              },
                              child: Text(
                                "forgotpass",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    color: const Color(0xFF4C2000)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Button(
                        onPressed: () async {
                          if (signInFormKey.currentState!.validate()) {
                            userlogin();
                          }
                        },
                        minimumSize: const Size(double.maxFinite, 64),
                        child: Text(
                          "login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 24,
                // ),
                // Text(
                //   'OR',
                //   style: GoogleFonts.inter(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400,
                //       color: Color(0xFF999999)),
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
                // socialButton(
                //     text: 'Continue with Google',
                //     color: Color(0xFFFFFFFF),
                //     png: true,
                //     icon: 'assets/images/Google.png'),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       AppLocalizations.of(context)!.donthaveaccount,
                //       style: GoogleFonts.inter(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: const Color(0xFF999999)),
                //       textAlign: TextAlign.center,
                //     ),
                //     TextButton(
                //       style: ButtonStyle(
                //           padding:
                //               MaterialStateProperty.all<EdgeInsetsGeometry>(
                //                   EdgeInsets.zero)),
                //       onPressed: () {
                //         Navigator.pushReplacementNamed(context, Register.id);
                //         email.clear();
                //         pass.clear();
                //       },
                //       child: Text(
                //         AppLocalizations.of(context)!.signup,
                //         style: GoogleFonts.inter(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             decoration: TextDecoration.underline,
                //             color: const Color(0xFF4C2000)),
                //         textAlign: TextAlign.center,
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
