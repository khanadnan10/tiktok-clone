import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/provider/signin/signin_provider.dart';
import 'package:tiktokclone/controller/provider/signin/signin_state.dart';
import 'package:tiktokclone/screens/Home.dart';
import 'package:tiktokclone/screens/auth/sigup.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String? _emailController;
  String? _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    print("email: $_emailController, password: $_passwordController");

    try {
      await context
          .read<SigninProvider>()
          .signin(email: _emailController!, password: _passwordController!);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print('form submittion error: signin_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SigninProvider>().state;
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Form(
                autovalidateMode: _autovalidateMode,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        'Tiktok',
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
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
                        },
                        onChanged: (newValue) => _emailController = newValue,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
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
                            return 'Password a valid email';
                          }
                        },
                        onChanged: (newValue) => _passwordController = newValue,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () async {
                          signInState.signinStatus == SigninStatus.submitting
                              ? null
                              : _submit();

                          print(
                              "email: $_emailController, password: $_passwordController");
                        },
                        child: Text(
                          signInState.signinStatus == SigninStatus.submitting
                              ? 'Loading'
                              : 'Log in',
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
                          TextButton(
                            onPressed: signInState.signinStatus ==
                                    SigninStatus.submitting
                                ? null
                                : () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signupPage())),
                            child: const Text(
                              'Register Now',
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
      ),
    );
  }
}
