import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/main_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Set bahasa untuk pesan Auth dan hilangkan peringatan X-Firebase-Locale null
  try {
    await FirebaseAuth.instance.setLanguageCode('id');
  } catch (_) {}
  runApp(const YouTubeCloneApp());
}

class YouTubeCloneApp extends StatelessWidget {
  const YouTubeCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        primaryColor: Colors.red,
      ),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
      },
      home: const _AuthGate(),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const MainScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
