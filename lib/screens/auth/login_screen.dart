import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/authController.dart';
import 'package:tiktokclone/screens/auth/signup_screen.dart';
import 'package:tiktokclone/screens/home.dart';
import 'package:tiktokclone/utils/utils.dart';
import 'package:tiktokclone/widgets/CustomTextField.dart';

import '../../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Provider.of<AuthController>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.6,
          backgroundColor: kGreyColor,
          title: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                color: kBackgroundColor,
              ),
            ),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: SizedBox(
            width: screenSize.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  isObscure: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isObscure: true,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtomColor,
                    ),
                    onPressed: () async {
                      if (_emailController.text.trim() != null &&
                          _passwordController.text.trim() != null) {
                        await _authController.signIn(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } else {
                        debugPrint('error snackbar');
                        Utils.snackBar(context, 'Enter all fields');
                      }
                    },
                    child: const Text(
                      'Log in',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                        debugPrint('Register Now');
                      }),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: kButtomColor,
                        ),
                      ),
                    ),
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
