import 'package:flutter/material.dart';

class dashboardClient extends StatefulWidget {
  const dashboardClient({super.key});

  @override
  State<dashboardClient> createState() => _dashboardClientState();
}

class _dashboardClientState extends State<dashboardClient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 123, 189, 1),
          flexibleSpace: Row(
            children: [
              Column(
                children: [Text('data'), Text('data')],
              ),
              Column(
                children: [Logo()],
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
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
        child: Image.asset("assets/images/logo.png"));
  }
}
