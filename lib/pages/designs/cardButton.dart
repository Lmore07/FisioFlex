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
          width: double.infinity,
          padding: EdgeInsetsDirectional.all(25),
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
              Expanded(
                child: Column(
                  children: [
                    Text(tittle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardButtonTaskWidget extends StatelessWidget {
  final String tittle;
  final IconData icon;
  final VoidCallback onPressed;
  final String? subtitle;
  const cardButtonTaskWidget({
    super.key,
    required this.tittle,
    required this.icon,
    this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(248, 184, 48, 1),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
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
            SizedBox(width: 20),
            Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Wrap(
                    children: [
                      Text(tittle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                if (subtitle != null)
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Wrap(children: [
                      Text(
                        subtitle!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                    ]),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
