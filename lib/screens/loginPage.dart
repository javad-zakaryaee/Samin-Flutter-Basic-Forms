import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    emailController.addListener(() {
      emailFormKey.currentState!.validate();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: emailFormKey,
            child: TextFormField(
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
          ),
          Form(
            key: passwordFormKey,
            child: TextFormField(
              focusNode: focusNode,
              validator: (value) {
                if (value == null || value.length < 8) {
                  focusNode.requestFocus();
                  return 'Password cant be less than 8 characters';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Password'),
              controller: passwordController,
            ),
          ),
          TextButton(
              onPressed: () {
                if (emailFormKey.currentState!.validate() &&
                    passwordFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You are logged in!')),
                  );
                }
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
