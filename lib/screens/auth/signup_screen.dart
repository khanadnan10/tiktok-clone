import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/provider/signup/signup_provider.dart';
import 'package:tiktokclone/controller/provider/signup/signup_state.dart';
import 'package:tiktokclone/screens/auth/signin_screen.dart';
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
  late File? _profileImage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final selectedImage =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (selectedImage != null) {
      _profileImage = File(selectedImage!.path);
      debugPrint('image selected');
    } else {
      debugPrint('image not selected');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final signupState = context.watch<SignupProvider>().state;
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
                  height: 50.0,
                ),
                Align(
                  child: GestureDetector(
                    onTap: () async {
                      await _pickImage();
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
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Enter all fields'),
                        //     backgroundColor: kButtomColor,
                        //   ),
                        // );
                      }
                      // else {
                      //   value.registerUser(
                      //       context,
                      //       _usernameController.text.trim(),
                      //       _emailController.text.trim(),
                      //       _passwordController.text.trim(),
                      //       value.profileImage);

                      //   // Moving back to login screen
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => LoginScreen()));
                      // }
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
                        Navigator.pop(context);
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
      // ),
      // ),
    );
  }
}
