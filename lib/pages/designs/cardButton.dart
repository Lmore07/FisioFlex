import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.all(25),
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 45,
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(tittle,
                        textAlign: TextAlign.center, style: textTitleStyleCard)
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
                  color: Colors.black,
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
                        color: Colors.black,
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

class cardDeveloper extends StatelessWidget {
  final String cargo;
  final String image;
  final String name;
  final String? number;
  final String? email;
  final String? linkedin;
  const cardDeveloper({
    super.key,
    required this.cargo,
    required this.image,
    required this.name,
    this.number,
    this.email,
    this.linkedin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: EdgeInsetsDirectional.all(5),
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                        width: 100, height: 100, fit: BoxFit.fitWidth, image),
                  ),
                ],
              ),
              spaced(10, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    name,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      textAlign: TextAlign.center,
                      cargo,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.black,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (number != null)
                    SocialButton(
                        icon: LineIcons.whatSApp,
                        onPressed: () {
                          launchUrl(Uri.parse('https://wa.me/$number'));
                        }),
                  if (email != null)
                    SocialButton(
                        icon: Icons.mail,
                        onPressed: () {
                          launchUrl(Uri.parse('mailto:$email'));
                        }),
                  if (linkedin != null)
                    SocialButton(
                        icon: LineIcons.linkedin,
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://www.linkedin.com/in/$linkedin'));
                        })
                ],
              )
            ],
          )),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  SocialButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      style: ButtonStyle(
          side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                color: Color.fromRGBO(25, 120, 168, 1),
              ))),
      icon: Icon(icon),
      onPressed: onPressed,
      color: Color.fromRGBO(25, 120, 168, 1),
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
