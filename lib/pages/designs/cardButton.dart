import 'package:flutter/material.dart';

class cardButtonWidget extends StatelessWidget {
  final String tittle;
  final IconData icon;
  final VoidCallback onPressed;
  const cardButtonWidget({
    super.key,
    required this.tittle,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
              color: Color.fromRGBO(248, 184, 48, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 45,
                  )
                ],
              ),
              Column(
                children: [
                  Text(tittle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
