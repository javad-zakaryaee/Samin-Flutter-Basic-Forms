import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Result extends StatelessWidget {
  Map<String, dynamic> resultData;
  Result({Key? key, required this.resultData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Hello!\nYour name is ${resultData['name']}\nYour email is ${resultData['email']}\nYour password is ${resultData['password']}\nYou were born on ${DateFormat.yMMMd().format(resultData['birthdate'])}\nYou live in ${resultData['city']}, ${resultData['province']}'),
      ),
    );
  }
}
