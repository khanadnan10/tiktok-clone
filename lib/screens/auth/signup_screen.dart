import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/authController.dart';
import 'package:tiktokclone/screens/auth/login_screen.dart';
import 'package:tiktokclone/utils/utils.dart';

import '../../utils/constants.dart';
import '../../widgets/CustomTextField.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: Consumer<AuthController>(
              builder: (context, value, child) => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    Align(
                      child: GestureDetector(
                        onTap: () {
                          value.pickImage();
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(
                            CupertinoIcons.person_badge_plus_fill,
                            color: kButtomColor,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: _usernameController,
                      hintText: 'Username',
                      isObscure: false,
                    ),
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
                        onPressed: () {
                          if (_emailController.text.isEmpty &&
                              _passwordController.text.isEmpty &&
                              _usernameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter all fields'),
                                backgroundColor: kButtomColor,
                              ),
                            );
                          } else {
                            value.registerUser(
                                context,
                                _usernameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                value.profileImage);

                            // Moving back to login screen
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        },
                        child: const Text(
                          'Register',
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
                          'Already have an account?',
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
                                    builder: (context) => LoginScreen()));
                          }),
                          child: const Text(
                            'Log in',
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
        ),
      ),
    );
  }
}
