import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ground_front_end/helpers/user_model.dart';
import 'package:ground_front_end/screens/account/confirm_screen.dart';
import 'package:ground_front_end/screens/analysis/history_screen.dart';
import 'package:ground_front_end/screens/analysis/page_view_screen.dart';
import 'package:provider/provider.dart';

import 'helpers/configure_amplify.dart';
import 'screens/account/confirm_reset_screen.dart';
import 'screens/account/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp(),
    ),
  );
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
          if (settings.name == '/history') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => HistoryScreen(),
              transitionsBuilder: (_, __, ___, child) => child,
            );
          }
          return MaterialPageRoute(builder: (_) => PageViewScreen());
          //home: PageViewScreen(),
        });
  }
}
