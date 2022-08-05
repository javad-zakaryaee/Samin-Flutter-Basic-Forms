import 'package:flutter/material.dart';
import 'signUpPage.dart';

class LoginPage extends StatefulWidget {
  bool firstLaunch;
  LoginPage({Key? key, this.firstLaunch = false}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: !widget.firstLaunch
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login_background.png"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 120, 50, 0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 150, top: 20),
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle(
                      fontFamily: 'Mukta',
                      fontWeight: FontWeight.w500,
                      fontSize: 36,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170, bottom: 30),
                child: Form(
                  key: emailFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: 'Email'),
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
                            prefixIcon: Icon(Icons.lock),
                            border: UnderlineInputBorder(),
                            labelText: 'Password'),
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () {
                    if (emailFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('You did it!')));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff1f3449),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              color: Colors.white,
                              Icons.arrow_forward,
                              size: 35,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff1f3449)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontFamily: 'Mutka'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color(0xff1f3449)),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
