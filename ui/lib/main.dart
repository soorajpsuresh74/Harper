import 'package:flutter/material.dart';
import 'package:harper/Pages/dashboardscreen.dart';
import 'package:harper/logger.dart';

import 'Pages/loginscreen.dart';
import 'Pages/staticanalysis.dart';
import 'Widget/Sast/Projectpanel/savedprojectfetch.dart';
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
      home: Scaffold(
        appBar: AppBar(
          title: Text(EnvLoader().getName() ?? ''),
        ),
        // body: LoginScreen(),
        // body: const DashboardScreen(),
        // body: StaticAnalysisPage(),
        body: SavedProjectsWidget(),
      ),
    );
  }
}
