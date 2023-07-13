import 'package:TeraFlex/pages/designs/background.dart';
import 'package:TeraFlex/pages/designs/buttons.dart';
import 'package:TeraFlex/pages/designs/txtParraph.dart';
import 'package:TeraFlex/pages/security/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../classes/textToSpeech.dart';
import '../designs/txtTitle.dart';

//VARIABLES GLOBALES
bool _isKeyboardOpen = false;
double _imageSize = 200.0;
double _top = 0.3;
String _txtInformation =
    'Hemos enviado un código de 4 dígitos a su correo electrónico. Ingrese el código para cambiar la contraseña.';
TextToSpeech textToSpeech = TextToSpeech();

class recoveryPassword extends StatefulWidget {
  const recoveryPassword({super.key});

  @override
  State<recoveryPassword> createState() => _recoveryPasswordState();
}

class _recoveryPasswordState extends State<recoveryPassword>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        Positioned.fill(child: background()),
        Positioned(top: 0, left: 0, right: 0, child: Logo()),
        Positioned.fill(
            top: MediaQuery.of(context).size.height * _top,
            left: 30,
            right: 30,
            child: recoveryForm()),
      ])),
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
      _top = keyboardOpen ? 0.2 : 0.3;
    });
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

class recoveryForm extends StatelessWidget {
  const recoveryForm({super.key});

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
            buttonTest(onPressed: () {
              textToSpeech.speak('¿Olvidó su contraseña?, No hay problema, ' +
                  _txtInformation);
            }),
            SizedBox(height: 20),
            txtParraph(label: _txtInformation),
            SizedBox(height: 20),
            Center(
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                enableActiveFill: true,
                obscureText: false,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    activeFillColor: Colors.white,
                    selectedColor: const Color.fromARGB(255, 46, 30, 30),
                    activeColor: Color.fromARGB(255, 36, 26, 26),
                    disabledColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    fieldWidth: 50,
                    fieldOuterPadding: EdgeInsets.only(right: 15, left: 15),
                    inactiveColor: Colors.white),
                animationDuration: Duration(milliseconds: 300),
                onChanged: (value) => {print(value)},
                onCompleted: (value) => {print(value)},
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 10),
            buttonFill(label: 'Aceptar', onPressed: () {}),
            SizedBox(height: 9),
            buttonTransparent(
                label: 'Volver',
                onPressed: () {
                  textToSpeech.stop();
                  Navigator.pushNamed(context, 'login');
                }),
            SizedBox(height: 20),
          ]),
        )
      ],
    );
  }
}
