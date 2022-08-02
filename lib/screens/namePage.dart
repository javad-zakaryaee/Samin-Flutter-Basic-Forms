import 'package:flutter/material.dart';
import './dropDownPage.dart';

class NamePage extends StatefulWidget {
  NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final nameFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter name')),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: nameFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length > 20 || value.isEmpty) {
                      return 'First name can\'t be empty or longer than 20 chars';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'First Name'),
                  controller: firstNameController,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length > 20 || value.isEmpty) {
                      return 'Last name can\'t be empty or longer than 20 chars';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Last Name'),
                  controller: lastNameController,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (nameFormKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DropDownPage()),
                        );
                      }
                    },
                    child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
