import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'data_fire.dart';
import 'firebase_options.dart';

void main() async {
  /*para garantir que o flutter já esteja inicializado, pois
  o firebase incia primeiro*/
  WidgetsFlutterBinding.ensureInitialized();

// inicializa as opções do Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplo Firebase',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(0, 6, 51, 111),
        brightness: Brightness.dark,
      ),
      home: const DataFire(),
    ));
  }
}