import 'package:fastlist/configuracoes.dart';
import 'package:fastlist/crialista.dart';
import 'package:fastlist/login.dart';
import 'package:fastlist/setores.dart';
import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  const Home({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '6',
        routes: {
          '1': (context) => const Home(),
          '4': (context) => const configuracoes(),
          '5': (context) => login(),
          '6': (context) => crialista(),
          '8': (context) => setores(),
        },
        home: Scaffold());
  }
}
