import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    AuthService? authService,
    FirebaseAuth? firebaseAuth,
  })  : _authService = authService ?? AuthService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _listenToAuthChanges();
  }

  final AuthService _authService;
  final FirebaseAuth _firebaseAuth;

  StreamSubscription<User?>? _authSubscription;
  User? _user;
  bool _isInitializing = true;

  User? get user => _user;
  bool get isInitializing => _isInitializing;
  bool get isLoggedIn => _user != null;

  Future<void> _listenToAuthChanges() async {
    final prefs = await SharedPreferences.getInstance();
    _user = _firebaseAuth.currentUser;
    await prefs.setBool(_PrefsKeys.isLoggedIn, _user != null);
    _authSubscription = _firebaseAuth.authStateChanges().listen(
      (event) async {
        _user = event;
        final prefInstance = await SharedPreferences.getInstance();
        await prefInstance.setBool(_PrefsKeys.isLoggedIn, _user != null);
        _isInitializing = false;
        notifyListeners();
      },
    );
    _isInitializing = false;
    notifyListeners();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _authService.signInWithEmail(email, password);
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _authService.registerWithEmail(email, password);
    await _firebaseAuth.signOut();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_PrefsKeys.isLoggedIn);
  }

  Future<bool> hasLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_PrefsKeys.isLoggedIn) ?? false;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

class _PrefsKeys {
  static const isLoggedIn = 'isLoggedIn';
}
