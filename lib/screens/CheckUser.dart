import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/authController.dart';
import 'package:tiktokclone/model/user.dart';
import 'package:tiktokclone/screens/auth/root.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AuthController>(context);
    return StreamProvider<User?>.value(
      value: _user.user,
      initialData: null,
      catchError: (context, e) {
        print('error in LocationModelNormal: ${e.toString()}');
        
        return null;
      },
      builder: (context, child) {
        return const MaterialApp(
          home: Root(),
        );
      },
    );
  }
}
/*
StreamBuilder(
        stream: _user.user,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData) {
              return LoginScreen();
            } else {
              HomeScreen();
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ), */
    

    /*
    Scaffold(
      body: StreamBuilder(
        stream: _user.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (_user.user != null ) {

            print("user is logged in");
            print(user);
            return HomeScreen();
          } else {
            print("user is not logged in");
            return LoginScreen();
          }
        },
      ), */