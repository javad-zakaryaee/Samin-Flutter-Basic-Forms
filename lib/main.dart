import 'package:flutter/material.dart';
import './screens/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sample Form App'),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: LoginPage()),
      ),
    );
  }
}
