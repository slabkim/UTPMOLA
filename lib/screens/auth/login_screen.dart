import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _error = null;
    });
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      // AuthGate will navigate automatically based on auth state
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'Login gagal. Coba lagi.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk'),
        backgroundColor: const Color(0xFF0F0F0F),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Selamat datang kembali',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Email wajib diisi';
                      }
                      if (!v.contains('@')) return 'Format email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      if (v.length < 6) {
                        return 'Minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text('Masuk'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.pushNamed(
                              context,
                              '/register',
                            ),
                    child: const Text('Belum punya akun? Daftar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
