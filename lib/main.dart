import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart' as app_auth;
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await FirebaseAuth.instance.setLanguageCode('id');
  } catch (_) {}
  runApp(const YouTubeCloneApp());
}

class YouTubeCloneApp extends StatelessWidget {
  const YouTubeCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<app_auth.AuthProvider>(
      create: (_) => app_auth.AuthProvider(),
      child: MaterialApp(
        title: 'YouTube Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F0F0F),
          primaryColor: Colors.red,
        ),
        routes: {
          LoginScreen.routeName: (_) => const LoginScreen(),
          RegisterScreen.routeName: (_) => const RegisterScreen(),
        },
        home: const _AuthGate(),
      ),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return Consumer<app_auth.AuthProvider>(
      builder: (_, auth, __) {
        if (auth.isInitializing) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (auth.isLoggedIn) {
          return const MainScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
