import 'package:flutter_sample/pages/login_page.dart';
import 'package:flutter_sample/pages/register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/settings_page.dart';
import 'package:flutter_sample/repositories/error_repository.dart';
import 'package:flutter_sample/stores/errors.dart';
import 'package:flutter_sample/stores/settings.dart';
import 'package:flutter_sample/pages/home_page.dart';
import 'package:flutter_sample/repositories/setting_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.prod");
  } else {
    await dotenv.load(fileName: ".env.local");
  }

  await Hive.initFlutter();
  await SettingRepository.register();
  await ErrorRepository.register();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Settings()),
        ChangeNotifierProvider(create: (_) => Errors()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasse',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
      ),
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        var routes = {
          "/login": (context) => LoginPage(),
          "/register": (context) => RegisterPage(),
          "/home": (context) => HomePage(),
          "/settings": (context) => SettingsPage(),
        };

        var builder = routes[settings.name];
        return builder != null ? MaterialPageRoute(builder: (ctx) => builder(ctx)) : null;
      },
    );
  }
}
