import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trabajo/pages/login/login_controller.dart';
import 'package:flutter_trabajo/pages/login/login_page.dart';
import 'package:flutter_trabajo/pages/mainPage/main_page.dart';
import 'package:flutter_trabajo/widgets/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()), // Aquí se añade el controlador
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

  class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindLO',
      debugShowCheckedModeBanner: false,
      initialRoute: "splash",
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
      routes: {
        "splash":(BuildContext context)=>Splash(),
        "login":(BuildContext context)=>LoginPage(),
        "principal":(BuildContext context)=>MainPage(),
      },
    );
    }

}

