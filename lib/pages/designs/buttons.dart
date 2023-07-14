import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:flutter/material.dart';

class buttonFill extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const buttonFill({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            minimumSize: Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(label,
              textAlign: TextAlign.center, style: styleButton(Colors.white)),
        )
      ],
    );
  }
}

class buttonTransparent extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const buttonTransparent({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: buttonColor)),
          ),
          child: Text(label,
              textAlign: TextAlign.center, style: styleButton(buttonColor)),
        )
      ],
    );
  }
}

class buttonVoiceIcon extends StatelessWidget {
  final VoidCallback onPressed;
  const buttonVoiceIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonVoiceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.record_voice_over, color: Colors.black)],
      ),
    );
  }
}

class buttonLogOut extends StatelessWidget {
  final VoidCallback onPressed;
  const buttonLogOut({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsetsDirectional.symmetric(vertical: 15),
        primary: buttonLogOutColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Cerrar Sesión',
              textAlign: TextAlign.start,
              style: textStyleButtonFinishAndVoiceAndLogOut(Colors.black)),
          SizedBox(width: 10),
          Icon(Icons.logout_rounded, color: Colors.black),
        ],
      ),
    );
  }
}

class buttonTest extends StatelessWidget {
  final VoidCallback onPressed;
  const buttonTest({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsetsDirectional.symmetric(vertical: 15),
        primary: buttonVoiceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dictar por voz',
            textAlign: TextAlign.start,
            style: textStyleButtonFinishAndVoiceAndLogOut(Colors.black),
          ),
          SizedBox(width: 10),
          Icon(Icons.record_voice_over_rounded, color: Colors.black),
        ],
      ),
    );
  }
}

class buttonFinish extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const buttonFinish({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonFinishColor,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: buttonFinishColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(label,
                  textAlign: TextAlign.center,
                  style: textStyleButtonFinishAndVoiceAndLogOut(Colors.white)),
            ],
          ),
        )
      ],
    );
  }
}
