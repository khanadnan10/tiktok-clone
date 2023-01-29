import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/model/user.dart';
import 'package:tiktokclone/screens/Home.dart';
import 'package:tiktokclone/screens/auth/login_screen.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<User?>(context);
    return _user != null ? HomeScreen() : LoginScreen();
  }
}
