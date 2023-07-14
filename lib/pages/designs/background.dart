import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:flutter/material.dart';

class background extends StatelessWidget {
  const background({super.key});

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
      children: [CurvedDesign()],
    );
  }
}

class CurvedDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: backgroundColorHeader,
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
    Paint paint = Paint()..color = backgroundColor;
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.2)
      ..cubicTo(size.width * 0.25, size.height * 0.4, size.width * 0.7,
          size.height * 0.2, size.width, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
