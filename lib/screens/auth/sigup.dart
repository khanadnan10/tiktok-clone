import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/provider/signup/signup_provider.dart';
import 'package:tiktokclone/controller/provider/signup/signup_state.dart';

import '../../utils/constants.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  File? _profileImage;

  Future<void> _pickImage() async {
    final selectedImage =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (selectedImage != null) {
      setState(() {
        _profileImage = File(selectedImage.path);
      });
      debugPrint('image selected');
    } else {
      debugPrint('image not selected');
      return;
    }
  }

  Future<void> _submit() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String username = _usernameController.text.trim();

    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();
    print('name: $username, email: $email, password: $password');

    try {
      await context.read<SignupProvider>().signup(
          email: email!,
          password: password!,
          username: username!,
          image: _profileImage!);
    } catch (e) {
      print('form submittion error: signin_screen');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _profileImage;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = context.watch<SignupProvider>().state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Align(
                      child: GestureDetector(
                        onTap: () async {
                          await _pickImage();
                        },
                        child: _profileImage != null
                            ? CircleAvatar(
                                radius: 50.0,
                                backgroundImage: FileImage(
                                  _profileImage!,
                                ),
                              )
                            : CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.grey[200],
                                child: const Icon(
                                  Icons.person,
                                  color: kButtomColor,
                                  size: 30.0,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        label: Text('Username'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username required';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be at least 2 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        label: Text('Email'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        label: Text('Password'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password required';
                        }
                        if (value.trim().length < 6) {
                          return 'Enter a valid Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        signUpState.signupStatus == SignupStatus.submitting
                            ? null
                            : _submit;
                      },
                      child: Text(
                        signUpState.signupStatus == SignupStatus.submitting
                            ? 'Loading...'
                            : 'Register',
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
                        TextButton(
                          onPressed: signUpState.signupStatus ==
                                  SignupStatus.submitting
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.blue),
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
