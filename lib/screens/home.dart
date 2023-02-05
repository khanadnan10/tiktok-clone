import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/provider/auth/auth_provider.dart';
import 'package:tiktokclone/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            context.read<AuthProvider>().signout();
          },
          child: Text(firebaseAuth.currentUser!.uid),
        ),
      ),
    );
  }
}
