import 'package:TeraFlex/pages/classes/messages.dart';
import 'package:TeraFlex/pages/classes/textToSpeech.dart';
import 'package:TeraFlex/pages/dashboard/options/detailTask.dart';
import 'package:TeraFlex/pages/designs/background.dart';
import 'package:TeraFlex/pages/designs/buttons.dart';
import 'package:TeraFlex/pages/designs/inputs.dart';
import 'package:TeraFlex/pages/designs/txtParraph.dart';
import 'package:TeraFlex/pages/designs/txtTitle.dart';
import 'package:flutter/material.dart';

//VARIABLES GLOBALES
bool _isKeyboardOpen = false;
double _imageSize = 200.0;
double _top = 0.35;
String _cedulaInput = '';
String _passwordInput = '';
String _confirmPasswordInput = '';
TextToSpeech textToSpeech = TextToSpeech();

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword>
    with WidgetsBindingObserver {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: background()),
            Positioned(top: 0, left: 0, right: 0, child: Logo()),
            Positioned.fill(
                top: MediaQuery.of(context).size.height * _top,
                left: 30,
                right: 30,
                child: forgotForm()),
          ],
        ),
      ),
    );
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
          duration: Duration(milliseconds: 300),
          height: _imageSize,
          child: Image.asset("assets/images/logo.png", width: _imageSize),
        ));
  }
}

class forgotForm extends StatelessWidget {
  const forgotForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(children: [
            txtTitle(
              label: 'Olvidé la contraseña',
            ),
            SizedBox(height: 15),
            txtParraph(label: "${getMessageRecoverPassword()}😀"),
            SizedBox(height: 15),
            buttonTest(
              onPressed: () {
                textToSpeech.speak(getMessageRecoverPassword());
              },
            ),
            SizedBox(height: 15),
            buttonTransparent(
                label: 'Volver',
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 30),
          ]),
        )
      ],
    );
  }
}
