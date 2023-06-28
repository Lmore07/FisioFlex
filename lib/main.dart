import 'package:fisioflex/pages/dashboard/dashboard.dart';
import 'package:fisioflex/pages/security/forgotPassword.dart';
import 'package:fisioflex/pages/security/login.dart';
import 'package:fisioflex/pages/security/recoveryPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fisioflex/pages/classes/sharedPreferences.dart';

Future<void> main() async {
  await dotenv.load(); // Carga las variables de entorno desde el archivo .env
  Map<String, dynamic>? savedResponse = await getJson('response');
  print(savedResponse);
  if (savedResponse != null) {
    runApp(const MainMenu());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FisioFlex',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 75, 170)),
        useMaterial3: true,
      ),
      initialRoute: 'dashboard',
      routes: {
        'login': (context) => const Login(),
        'dashboard': (context) => const dashboardClient(),
        'recovery-password': (context) => const forgotPassword(),
        'reset-password': (context) => const recoveryPassword(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FisioFlex',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 75, 170)),
        useMaterial3: true,
      ),
      initialRoute: 'dashboard',
      routes: {
        'login': (context) => const Login(),
        'dashboard': (context) => const dashboardClient(),
        'recovery-password': (context) => const forgotPassword(),
        'reset-password': (context) => const recoveryPassword(),
      },
    );
  }
}
