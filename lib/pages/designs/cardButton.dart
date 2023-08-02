import 'package:TeraFlex/pages/classes/styles.dart';
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
            color: cardColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
            spaced(0, 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 160),
                  child: Wrap(
                    children: [Text(tittle, style: textTitleStyleCard)],
                  ),
                ),
                spaced(10, 0),
                if (subtitle != null)
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 160),
                    child: Wrap(children: [
                      Icon(
                        Icons.access_time_filled_sharp,
                        color: Colors.white,
                      ),
                      Text(
                        subtitle!,
                        textAlign: TextAlign.left,
                        style: textSubtitleStyleCard,
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

class cardNotification extends StatelessWidget {
  final String tittle;
  final VoidCallback onPressed;
  final String? subtitle;

  const cardNotification({
    super.key,
    required this.tittle,
    this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 160),
                child: Wrap(
                  children: [Text(tittle, style: textTitleStyleCard)],
                ),
              ),
              spaced(10, 0),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 160),
                child: Wrap(children: [
                  Text(
                    subtitle!,
                    textAlign: TextAlign.left,
                    style: textSubtitleStyleCard,
                  ),
                ]),
              )
            ],
          ),
          SizedBox(width: 25),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            FloatingActionButton(
              backgroundColor: buttonFinishColor,
              onPressed: onPressed,
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
                size: 40,
              ),
            )
          ])
        ],
      ),
    );
  }
}
