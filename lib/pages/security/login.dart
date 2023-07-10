import 'package:fisioflex/pages/classes/alerts.dart';
import 'package:fisioflex/pages/dashboard/dashboard.dart';
import 'package:fisioflex/pages/designs/background.dart';
import 'package:fisioflex/pages/designs/buttons.dart';
import 'package:fisioflex/pages/designs/inputs.dart';
import 'package:fisioflex/pages/designs/txtTitle.dart';
import 'package:fisioflex/pages/interfaces/interfaces.dart';
import 'package:fisioflex/pages/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//VARIABLES GLOBALES
bool _isKeyboardOpen = false;
double _imageSize = 200.0;
double _top = 0.35;
String _userInput = '';
String _passwordInput = '';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: createLogin()),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardOpen = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    setState(() {
      _isKeyboardOpen = keyboardOpen;
      _imageSize = keyboardOpen ? 100.0 : 200.0;
      _top = keyboardOpen ? 0.2 : 0.35;
    });
  }
}

class createLogin extends StatelessWidget {
  const createLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(child: background()),
      Positioned(top: 0, left: 0, right: 0, child: Logo()),
      Positioned.fill(
          top: MediaQuery.of(context).size.height * _top,
          left: 30,
          right: 30,
          child: LoginForm()),
    ]);
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtTitle(
              label: 'Inicio de sesión',
            ),
            SizedBox(height: 15),
            InputWidget(
                enable: true,
                label: 'Usuario',
                hint: 'Ingresa tu usuario',
                value: (value) => {_userInput = value},
                keyboardType: TextInputType.number),
            InputWidget(
                enable: true,
                label: 'Contraseña',
                hint: 'Ingresa tu contraseña',
                value: (value) => {_passwordInput = value},
                keyboardType: TextInputType.visiblePassword),
            buttonFill(
                label: 'Ingresar',
                onPressed: () {
                  login(context);
                }),
            SizedBox(height: 9),
            SizedBox(height: 40),
            btnForgotPassword()
          ],
        ),
      ),
    ]);
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.topCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: _imageSize,
          child: Image.asset("assets/images/logo.png", width: _imageSize),
        ));
  }
}

class btnForgotPassword extends StatefulWidget {
  const btnForgotPassword({super.key});

  @override
  State<btnForgotPassword> createState() => _btnForgotPasswordState();
}

class _btnForgotPasswordState extends State<btnForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'recovery-password');
          },
          child: RichText(
            text: TextSpan(
                text: 'Olvidé la contraseña',
                style: TextStyle(
                    color: Color.fromRGBO(0, 123, 189, 1),
                    decoration: TextDecoration.underline,
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
        ),
        onHover: (PointerHoverEvent event) {
          setState(() {});
        },
      ),
    );
  }
}

void login(BuildContext context) {
  CustomEasyLoading.instance.showLoading('Iniciando sesión...');
  loginService(Credentials(user: _userInput, password: _passwordInput))
      .then((loggedIn) {
    switch (loggedIn) {
      case 0:
        CustomEasyLoading.instance.dismiss();
        CustomEasyLoading.instance.showError('APP es solo para pacientes');
        break;
      case 1:
        CustomEasyLoading.instance.dismiss();
        CustomEasyLoading.instance.showSuccess('Bienvenido');
        Navigator.pushNamed(context, 'dashboard');
        break;
      case 2:
        CustomEasyLoading.instance.dismiss();
        CustomEasyLoading.instance
            .showError('Usuario o contraseña incorrectos');
        break;
      case 3:
        CustomEasyLoading.instance.dismiss();
        CustomEasyLoading.instance.showError('Ha ocurrido un error inesperado');
        break;
      default:
    }
  });
}
