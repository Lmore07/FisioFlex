import 'package:TeraFlex/pages/dashboard/dashboard.dart';
import 'package:TeraFlex/pages/dashboard/options/detailTask.dart';
import 'package:TeraFlex/pages/dashboard/options/help.dart';
import 'package:TeraFlex/pages/dashboard/options/myAccount.dart';
import 'package:TeraFlex/pages/dashboard/options/tasks.dart';
import 'package:TeraFlex/pages/security/forgotPassword.dart';
import 'package:TeraFlex/pages/security/login.dart';
import 'package:TeraFlex/pages/security/recoveryPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String? savedResponse;

Future<void> main() async {
  await dotenv.load();
  //await removeData('token');
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura la inicialización de Flutter
  savedResponse = await getString('token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeraFlex',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 75, 170)),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: (savedResponse == null) ? 'login' : 'dashboard',
      routes: {
        'login': (context) => const Login(),
        'dashboard': (context) => const dashboardClient(),
        'recovery-password': (context) => const forgotPassword(),
        'reset-password': (context) => const recoveryPassword(),
        'tasks-list': (context) => const tasksList(),
        'detail-task': (context) => const detailTask(),
        'my-account': (context) => const myAccount(),
        'help': (context) => const helpMenu(),
      },
    );
  }
}
