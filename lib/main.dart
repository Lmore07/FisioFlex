import 'package:fisioflex/pages/dashboard/dashboard.dart';
import 'package:fisioflex/pages/dashboard/options/detailTask.dart';
import 'package:fisioflex/pages/dashboard/options/myAccount.dart';
import 'package:fisioflex/pages/dashboard/options/tasks.dart';
import 'package:fisioflex/pages/security/forgotPassword.dart';
import 'package:fisioflex/pages/security/login.dart';
import 'package:fisioflex/pages/security/recoveryPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fisioflex/pages/classes/sharedPreferences.dart';

Map<String, dynamic>? savedResponse;

Future<void> main() async {
  await dotenv.load(); // Carga las variables de entorno desde el archivo .env
  savedResponse = await getJson('response');
  print(savedResponse);
  runApp(const MyApp());
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
      initialRoute: (savedResponse == null) ? 'login' : 'dashboard',
      routes: {
        'login': (context) => const Login(),
        'dashboard': (context) => const dashboardClient(),
        'recovery-password': (context) => const forgotPassword(),
        'reset-password': (context) => const recoveryPassword(),
        'tasks-list': (context) => const tasksList(),
        'detail-task': (context) => const detailTask(),
        'my-account': (context) => const myAccount(),
      },
    );
  }
}
