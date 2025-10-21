import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapCodeToMessage(e.code));
    }
  }

  Future<UserCredential> registerWithEmail(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapCodeToMessage(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _mapCodeToMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email tidak valid';
      case 'user-disabled':
        return 'Akun dinonaktifkan';
      case 'user-not-found':
        return 'Akun tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'weak-password':
        return 'Password terlalu lemah (min 6 karakter)';
      case 'operation-not-allowed':
        return 'Operasi tidak diizinkan';
      default:
        return 'Terjadi kesalahan. Coba lagi.';
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

