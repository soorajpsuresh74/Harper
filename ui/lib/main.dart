import 'package:flutter/material.dart';
import 'package:harper/Pages/dashboardscreen.dart';
import 'package:harper/logger.dart';

import 'Pages/loginscreen.dart';
import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvLoader().load();
  Logger().info('Application started');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: EnvLoader().getName() ?? '',
      home: const ProjectsAndAppplication(),
      // home: const LoginScreen(),
      // body: LoginScreen(),
    );
  }
}
