import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_practice/screens/signUpResultPage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var birthdayController = TextEditingController();
  late DateTime birthdate;
  var securityQuestion1Controller = TextEditingController();
  var securityQuestion2Controller = TextEditingController();
  var provinceDropDownValue = 'Choose Province';
  var cityDropDownValue = 'Choose City';
  String secQuestion1Value = 'Choose Security Question';
  String secQuestion2Value = 'Choose Security Question';
  List<String>? cities;
  Map<String, List<String>> cityList = {
    'Mazandaran': ['Amol', 'Babol', 'Choose City'],
    'Tehran': ['Tehran', 'Karaj', 'Choose City']
  };
  var securityQuestions = [
    'What\'t the name of your first pet?',
    'What\'s the first place you flew?',
    'What\'s the name of your childhood?',
    'Choose Security Question'
  ];
  var visibleFlag1 = false;
  var visibleFlag2 = false;

  final formKey = GlobalKey<FormState>();
  final answer1Key = GlobalKey();
  final answer2Key = GlobalKey();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      setState(() {
        birthdate = pickedDate;
        birthdayController.text = DateFormat.yMMMMd().format(birthdate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 100, 50, 0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/signup_background.png"),
              fit: BoxFit.cover),
        ),
        child: Theme(
          data: ThemeData(
              canvasColor: Color(0xff1f3449),
              errorColor: Color.fromARGB(255, 255, 218, 182),
              textTheme: const TextTheme(
                subtitle1: TextStyle(color: Colors.white),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                  prefixIconColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Create\nAccount',
                style: TextStyle(
                    fontFamily: 'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                    color: Colors.white),
              ),
              Container(
                height: 450,
                padding: EdgeInsets.only(bottom: 50, top: 70),
                margin: EdgeInsets.only(bottom: 50),
                child: CupertinoScrollbar(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Name can\'t be empty';
                                } else if (double.tryParse(
                                        nameController.text) !=
                                    null) {
                                  return 'Name can\'t contain numbers';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Name'),
                            ),
                            TextFormField(
                              controller: emailController,
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
                                  prefixIcon: Icon(Icons.email),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Email'),
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Password'),
                              validator: (val) {
                                if (val == null ||
                                    val.length < 8 ||
                                    val.isEmpty) {
                                  return 'Password can\'t be shorter than 8 characters';
                                } else if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  return 'Passwords dont match';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              validator: (val) {
                                if (passwordController.text !=
                                        confirmPasswordController.text ||
                                    confirmPasswordController.text.isEmpty) {
                                  return 'Passwords dont match';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Confirm Password'),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.none,
                              onTap: () => _selectDate(context),
                              controller: birthdayController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Birthday can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.date_range),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Birth Date'),
                            ),
                            DropdownButtonFormField(
                              value: provinceDropDownValue,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.flag)),
                              validator: (String? val) {
                                if (val != null &&
                                    !val.toString().contains('Choose')) {
                                  return null;
                                } else {
                                  return 'Pick a value.';
                                }
                              },
                              items: <String>[
                                'Choose Province',
                                'Mazandaran',
                                'Tehran'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  provinceDropDownValue = val.toString();
                                  cities = cityList[val.toString()];
                                  cityDropDownValue = 'Choose City';
                                });
                              },
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.house),
                                  hintText: 'Choose City',
                                  hintStyle: TextStyle(
                                      color: Color(0xff1f3449), height: 2)),
                              validator: (String? val) {
                                if (val != null &&
                                    !val.toString().contains('Choose')) {
                                  return null;
                                } else {
                                  return 'Pick a value.';
                                }
                              },
                              value: cityDropDownValue,
                              items: cities?.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  cityDropDownValue = val.toString();
                                });
                              },
                            ),
                            DropdownButtonFormField(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.security)),
                                validator: (val) {
                                  if (val != null &&
                                      !val.toString().contains('Choose')) {
                                    return null;
                                  } else {
                                    return 'Pick a question';
                                  }
                                },
                                value: secQuestion1Value,
                                items: securityQuestions.where((element) {
                                  if (element == secQuestion2Value &&
                                      !element.contains('Choose')) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                }).map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  secQuestion1Value = val.toString();
                                  setState(() {
                                    if (secQuestion1Value.contains('Choose')) {
                                      visibleFlag1 = false;
                                    } else {
                                      visibleFlag1 = true;
                                      Scrollable.ensureVisible(
                                          answer1Key.currentContext ?? context);
                                    }
                                  });
                                }),
                            Visibility(
                              key: answer1Key,
                              visible: visibleFlag1,
                              child: TextFormField(
                                controller: securityQuestion1Controller,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.question_answer),
                                    border: UnderlineInputBorder(),
                                    labelText: 'Answer 1'),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Answer can\'t be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            DropdownButtonFormField(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.security)),
                                validator: (val) {
                                  if (val != null &&
                                      !val.toString().contains('Choose')) {
                                    return null;
                                  } else {
                                    return 'Pick a question';
                                  }
                                },
                                value: secQuestion2Value,
                                items: securityQuestions.where((element) {
                                  if (element == secQuestion1Value &&
                                      !element.contains('Choose')) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                }).map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    secQuestion2Value = val.toString();
                                    if (secQuestion2Value.contains('Choose')) {
                                      visibleFlag2 = false;
                                    } else {
                                      visibleFlag2 = true;
                                      Scrollable.ensureVisible(
                                          answer2Key.currentContext ?? context);
                                    }
                                  });
                                }),
                            Visibility(
                              key: answer2Key,
                              visible: visibleFlag2,
                              child: TextFormField(
                                controller: securityQuestion2Controller,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.question_answer),
                                    border: UnderlineInputBorder(),
                                    labelText: 'Answer 2'),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Answer can\'t be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff1f3449)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Map<String, dynamic> data = {
                              'name': nameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                              'birthdate': birthdate,
                              'province': provinceDropDownValue,
                              'city': cityDropDownValue,
                              'secQuestion1': secQuestion1Value,
                              'secAnswer1': securityQuestion1Controller.text,
                              'secQuestion2': secQuestion2Value,
                              'secAnswer2': securityQuestion2Controller.text
                            };
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Result(resultData: data)));
                          }
                        },
                        child: const Text('Sign Up')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
