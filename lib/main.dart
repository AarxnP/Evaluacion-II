import 'package:evaluacion_02/screens/servicios.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_02/screens/login.dart';
import 'package:evaluacion_02/screens/registro.dart';
import 'package:evaluacion_02/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/services': (context) => ServicesScreen (), // Agrega esta línea
      },
    );
  }
}
