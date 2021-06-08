import 'package:flutter/material.dart';
import 'package:ground_front_end/screens/confirm_screen.dart';
import 'package:ground_front_end/screens/page_view_screen.dart';

import 'helpers/configure_amplify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        onGenerateRoute: (settings) {
          if (settings.name == '/confirm') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  ConfirmScreen(data: settings.arguments as LoginData),
              transitionsBuilder: (_, __, ___, child) => child,
            );
          }

          if (settings.name == '/confirm-reset') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  ConfirmResetScreen(data: settings.arguments as LoginData),
              transitionsBuilder: (_, __, ___, child) => child,
            );
          }

          if (settings.name == '/dashboard') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => DashboardScreen(),
              transitionsBuilder: (_, __, ___, child) => child,
            );
          }
          return MaterialPageRoute(builder: (_) => PageViewScreen());
          //home: PageViewScreen(),
        });
  }
}
