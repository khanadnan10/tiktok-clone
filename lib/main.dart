import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclone/controller/firebase/authRepository.dart';
import 'package:tiktokclone/controller/provider/auth/auth_provider.dart';
import 'package:tiktokclone/controller/provider/signin/signin_provider.dart';
import 'package:tiktokclone/controller/provider/signup/signup_provider.dart';
import 'package:tiktokclone/firebase_options.dart';
import 'package:tiktokclone/screens/splash_page.dart';
import 'package:tiktokclone/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        Provider<AuthRepository>(
            create: (context) => AuthRepository(
                firebaseFirestore: firebaseFirestore,
                firebaseAuth: firebaseAuth)),
        StreamProvider<fbAuth.User?>(
            create: (context) => context.read<AuthRepository>().user,
            initialData: null),
        ChangeNotifierProxyProvider<fbAuth.User?, AuthProvider>(
            create: (context) =>
                AuthProvider(authRepository: context.read<AuthRepository>()),
            update: (BuildContext context, fbAuth.User? user,
                    AuthProvider? authProvider) =>
                authProvider!..update(user)),
        ChangeNotifierProvider<SigninProvider>(
            create: (context) =>
                SigninProvider(authRepository: context.read<AuthRepository>())),
        ChangeNotifierProvider<SignupProvider>(
            create: (context) =>
                SignupProvider(authRepository: context.read<AuthRepository>())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: kBackgroundColor,
          ),
          title: 'Tiktok Clone',
          home: SplashScreen()),
    );
  }
}
