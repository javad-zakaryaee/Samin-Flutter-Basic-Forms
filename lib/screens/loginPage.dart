import 'package:flutter/material.dart';
import 'namePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Form(
              key: emailFormKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Email'),
                    controller: emailController,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Password cant be less than 8 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Password'),
                    controller: passwordController,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (emailFormKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NamePage()),
                          );
                        }
                      },
                      child: const Text('Login')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
