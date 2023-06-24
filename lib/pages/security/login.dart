import 'package:fisioflex/pages/designs/background.dart';
import 'package:fisioflex/pages/designs/inputs.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [backGround(), LoginForm()],
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtTitle(),
            SizedBox(height: 15),
            InputWidget(
                label: 'Usuario',
                hint: 'Ingresa tu usuario',
                value: (value) {},
                keyboardType: TextInputType.text),
          ],
        ),
      ),
    );
  }
}

class txtTitle extends StatelessWidget {
  const txtTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Inicio de sesión',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF007BBD),
        fontSize: 28,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
