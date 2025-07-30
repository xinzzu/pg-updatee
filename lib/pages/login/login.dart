import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/main.dart';
import 'package:pgcard/widgets/login/button.dart';
import 'package:pgcard/widgets/login/text_field.dart';
import 'package:provider/provider.dart';
import 'package:pgcard/providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _rmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _submitLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String rm = _rmController.text.trim();
      String password = _passwordController.text.trim();

      Provider.of<LoginProvider>(context, listen: false)
          .login(rm, password)
          .then((isSuccess) {
        if (isSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun yang anda masukkan salah')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF4C4DDC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Masuk ke Akun',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'No RM',
                    hint: 'Masukkan No RM',
                    iconPath: 'assets/icons/login/rm.svg',
                    isPassword: false,
                    controller: _rmController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No RM harus diisi!';
                      }
                      return null;
                    },
                    suffixIcon: _rmController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _rmController.clear();
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Masukkan password',
                    iconPath: 'assets/icons/login/password.svg',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password harus diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  if (loginProvider.isLoading)
                    const CircularProgressIndicator()
                  else
                    LoginButton(
                      onPressed: () {
                        _submitLogin(context);
                      },
                    ),
                  const SizedBox(height: 40),
                  const Text(
                    'Pharmagenic App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'By MABIF',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
