import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final IconData? icon;
  final String? username;
  final String tittle;
  final String subTittle;
  final VoidCallback? onPressed;

  const AppBarCustom({
    super.key,
    this.username,
    this.icon,
    required this.tittle,
    required this.subTittle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(0, 123, 189, 1),
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: onPressed,
                  child: Row(
                    children: [
                      if (icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(icon, color: Colors.white),
                        ),
                      Text(subTittle,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (username != null)
                      Text(tittle + ' ' + username!,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    if (username == null)
                      Text(tittle,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: 20, right: 20, bottom: 10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
    );
  }
}
