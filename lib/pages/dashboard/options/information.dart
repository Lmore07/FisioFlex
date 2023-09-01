import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/cardButton.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationDev extends StatefulWidget {
  const InformationDev({super.key});

  @override
  State<InformationDev> createState() => _InformationDevState();
}

class _InformationDevState extends State<InformationDev> {
  @override
  Widget build(BuildContext context) {
    const textStyleAdmin = TextStyle(
        fontSize: 17,
        fontFamily: 'Inter',
        color: Colors.black,
        fontStyle: FontStyle.normal);
    const textStyleTitle = TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        child: AppBarCustom(
          tittle: 'Acerca de',
          subTittle: 'Atrás',
          icon: Icons.arrow_back_rounded,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsetsDirectional.only(top: 20, end: 25, start: 25),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blueAccent),
                    spaced(0, 5),
                    Text(
                      'Acerca de',
                      style: textStyleTitle,
                    )
                  ],
                ),
              ),
              spaced(10, 0),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 25, start: 25),
                child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        color: Colors.black),
                    'Esta aplicación web ha sido desarrollada como parte del proyecto de vinculación “Tecnologías de la Información y Comunicación enfocadas a la discapacidad en la zona de influencia de la UTEQ” (F&C), de la Carrera de Ingeniería en Sistemas/Software, perteneciente a la Facultad de Ciencias de la Ingeniería, de la Universidad Técnica Estatal de Quevedo, en cooperación con la Dirección de Gestión de Desarrollo Social del GAD de Quevedo. Con este proyecto, se pretende mejorar la atención de terapias de los pacientes de la ciudad de Quevedo.'),
              ),
              spaced(15, 0),
              Text('Desarrollada por', style: textStyleTitle),
              spaced(15, 0),
              Desarrolladores(),
              spaced(15, 0),
              Text('Dirigido por', style: textStyleTitle),
              spaced(15, 0),
              Direccion(),
              spaced(15, 0),
              Text('En la administración de', style: textStyleTitle),
              spaced(15, 0),
              Administracion(textStyleAdmin: textStyleAdmin),
              spaced(15, 0),
              Text(
                'Con la colaboración de',
                style: textStyleTitle,
              ),
              spaced(15, 0),
              Colaboracion(textStyleAdmin: textStyleAdmin),
              spaced(15, 0),
              Text(
                'Para más información, visite',
                style: textStyleTitle,
              ),
              spaced(15, 0),
              Links(),
              spaced(15, 0),
              Footer(),
              spaced(15, 0)
            ],
          ),
        ),
      ),
    ));
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 25, start: 25),
      child: Column(
        children: [
          Text(
            '© 2023 Universidad Técnica Estatal de Quevedo',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            'Campus "Ingeniero Manuel Agustín Haz Álvarez"',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            'Av. Quito km. 1 1/2 vía a Santo Domingo de los Tsáchilas',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            '(+593) 5 3702-220 Ext. 8039',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            'Email: info@uteq.edu.ec',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            'Quevedo - Los Ríos - Ecuador',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          spaced(5, 0),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse('https://www.uteq.edu.ec/'),
                  mode: LaunchMode.externalApplication);
            },
            child: Text(
              'https://www.uteq.edu.ec/',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  color: Colors.blue,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class Links extends StatelessWidget {
  const Links({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse('https://fyc.uteq.edu.ec'),
                mode: LaunchMode.externalApplication);
          },
          child: Text(
            'https://fyc.uteq.edu.ec',
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                color: Colors.blue,
                fontSize: 16),
          ),
        ),
        spaced(10, 0),
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse('https://www.facebook.com/fycuteq'),
                mode: LaunchMode.externalApplication);
          },
          child: Text(
            'https://www.facebook.com/fycuteq',
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                color: Colors.blue,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class Colaboracion extends StatelessWidget {
  const Colaboracion({
    super.key,
    required this.textStyleAdmin,
  });

  final TextStyle textStyleAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 25, start: 25),
      child: Column(
        children: [
          Text(
            'Rosa Andrada',
            style: textStyleAdmin,
            textAlign: TextAlign.center,
          ),
          Text(
            'Dirección de Gestión de Desarrollo Social del Gobierno Autónomo Descentralizado del cantón Quevedo',
            style: textStyleAdmin,
            textAlign: TextAlign.center,
          ),
          spaced(5, 0),
        ],
      ),
    );
  }
}

class Desarrolladores extends StatelessWidget {
  const Desarrolladores({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 25, start: 25),
          child: cardDeveloper(
            cargo: 'Líder del proyecto',
            image:
                'https://res.cloudinary.com/dfzyxagbc/image/upload/v1691903628/TeraFlex%20-%20Vinculaci%C3%B3n/Profile-photo_dvkvlo.jpg',
            name: 'Jordan Vera Coello',
            number: '+593980576250',
            email: 'jverac12@uteq.edu.ec',
            linkedin: 'jordanfvc26',
          ),
        ),
        spaced(10, 0),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 25, start: 25),
          child: cardDeveloper(
            cargo: 'Líder técnico',
            image:
                'https://res.cloudinary.com/dfzyxagbc/image/upload/v1691903729/TeraFlex%20-%20Vinculaci%C3%B3n/Ivan_Manzaba_Profile_rqwqsm.jpg',
            name: 'Iván Manzaba Garcés',
            number: '+593980576250',
            email: 'imanzabag@uteq.edu.ec',
            linkedin: 'iván-manzaba-1ab312214',
          ),
        ),
        spaced(10, 0),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 25, start: 25),
          child: cardDeveloper(
            cargo: 'Desarrollador móvil',
            image:
                'https://res.cloudinary.com/dfzyxagbc/image/upload/v1691905705/TeraFlex%20-%20Vinculaci%C3%B3n/Luis_Moreira_Profile_zxey6k.jpg',
            name: 'Luis Moreira Torres',
            number: '+593994634484',
            email: 'lmoreirat@uteq.edu.ec',
            linkedin: 'luis-enrique-moreira-torres-317334252',
          ),
        ),
        spaced(10, 0),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 25, start: 25),
          child: cardDeveloper(
            cargo: 'Desarrollador backend',
            image:
                'https://res.cloudinary.com/dfzyxagbc/image/upload/v1691903729/TeraFlex%20-%20Vinculaci%C3%B3n/Luis_de_la_Cruz_Profile_cmw3au.jpg',
            name: 'Luis De La Cruz',
            number: '+593963121825',
            email: 'ldelacruzg@uteq.edu.ec',
            linkedin: 'luis-de-la-cruz',
          ),
        ),
      ],
    );
  }
}

class Direccion extends StatelessWidget {
  const Direccion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 25, start: 25),
          child: cardDeveloper(
            cargo: 'Director del proyecto de vinculación',
            image:
                'https://res.cloudinary.com/dfzyxagbc/image/upload/v1691905728/TeraFlex%20-%20Vinculaci%C3%B3n/user-profile_fbdmtf.png',
            name: 'Orlando Erazo',
            email: 'oerazo@uteq.edu.ec',
          ),
        ),
        spaced(10, 0),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 25, start: 25),
          child: cardDeveloper(
            cargo: 'Coordinador del proyecto de vinculación',
            image:
                'https://res.cloudinary.com/dfzyxagbc/image/upload/v1691905728/TeraFlex%20-%20Vinculaci%C3%B3n/user-profile_fbdmtf.png',
            name: 'Rafael Salinas',
            email: 'rsalinas@uteq.edu.ec',
          ),
        ),
      ],
    );
  }
}

class Administracion extends StatelessWidget {
  const Administracion({
    super.key,
    required this.textStyleAdmin,
  });

  final TextStyle textStyleAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 25, start: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Eduardo Díaz',
            style: textStyleAdmin,
            textAlign: TextAlign.center,
          ),
          Text(
            '(Rector)',
            style: textStyleAdmin,
            textAlign: TextAlign.center,
          ),
          spaced(5, 0),
          Text(
            'Jenny Torres',
            style: textStyleAdmin,
            textAlign: TextAlign.center,
          ),
          Text(
            '(Vicerrectora Académica)',
            style: textStyleAdmin,
            textAlign: TextAlign.center,
          ),
          spaced(5, 0),
          Text(
            'Roberto Pico',
            style: textStyleAdmin,
          ),
          Text(
            '(Vicerrector Administrativo)',
            style: textStyleAdmin,
          ),
          spaced(5, 0),
          Text(
            'Leonardo Matute',
            style: textStyleAdmin,
          ),
          Text(
            '(Director de Vinculación)',
            style: textStyleAdmin,
          ),
          spaced(5, 0),
          Text(
            'Patricio Alcócer',
            style: textStyleAdmin,
          ),
          Text(
            '(Decano)',
            style: textStyleAdmin,
          ),
          spaced(5, 0),
          Text(
            'Stalin Carreño',
            style: textStyleAdmin,
          ),
          Text(
            '(Unidad de TIC)',
            style: textStyleAdmin,
          ),
        ],
      ),
    );
  }
}
