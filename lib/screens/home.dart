import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/authController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetail =
        Provider.of<AuthController>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            userDetail.signOut();
            // Navigator.pop(context);
          },
          child: Text('Sign out'),
        ),
      ),
    );
  }
}
