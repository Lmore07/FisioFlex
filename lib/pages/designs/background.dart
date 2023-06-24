import 'package:flutter/material.dart';

class background extends StatefulWidget {
  const background({super.key});

  @override
  State<background> createState() => _backgroundState();
}

class _backgroundState extends State<background> {
  @override
  Widget build(BuildContext context) {
    return backGround();
  }
}

class backGround extends StatelessWidget {
  const backGround({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [CurvedDesign(), Logo()],
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
        margin: EdgeInsets.symmetric(vertical: 30),
        alignment: AlignmentDirectional.topCenter,
        child: Image.asset("assets/images/logo.png"));
  }
}

class CurvedDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(0, 123, 189, 1),
            height: MediaQuery.of(context).size.height * 1,
          ),
          CustomPaint(
            painter: CurvePainter(),
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromRGBO(156, 211, 221, 1);
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.25)
      ..cubicTo(size.width * 0.25, size.height * 0.5, size.width * 0.7,
          size.height * 0.2, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
