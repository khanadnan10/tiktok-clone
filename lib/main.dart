import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/authController.dart';
import 'package:tiktokclone/firebase_options.dart';
import 'package:tiktokclone/screens/auth/root.dart';
import 'package:tiktokclone/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthController()),
          StreamProvider(
            create: (context) => context.read<AuthController>().authState,
            initialData: null,
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: kBackgroundColor,
            ),
            title: 'Flutter Demo',
            home: Root()));
  }
}
