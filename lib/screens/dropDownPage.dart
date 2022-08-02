import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  DropDownPage({Key? key}) : super(key: key);

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  List<String>? cities = null;
  final formKey = GlobalKey<FormState>();
  var dropDownValue = 'Choose Province';
  var dropDownCity = 'Choose City';
  Map<String, List<String>> cityList = {
    'Mazandaran': ['Amol', 'Babol', 'Choose City'],
    'Tehran': ['Tehran', 'Karaj', 'Choose City']
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick a province')),
      body: Center(
          child: Container(
        margin: EdgeInsets.all(15),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: dropDownValue,
                  validator: (String? val) {
                    if (val != null && !val.toString().contains('Choose')) {
                      return null;
                    } else {
                      return 'Pick a value.';
                    }
                  },
                  items: <String>['Choose Province', 'Mazandaran', 'Tehran']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      dropDownValue = val.toString();
                      cities = cityList[val.toString()];
                    });
                  },
                ),
                DropdownButtonFormField(
                  validator: (String? val) {
                    if (val != null && !val.toString().contains('Choose')) {
                      return null;
                    } else {
                      return 'Pick a value.';
                    }
                  },
                  value: dropDownCity,
                  items: cities?.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      dropDownCity = val.toString();
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('YOU DID IT!')));
                      }
                    },
                    child: Text('Submit'))
              ],
            )),
      )),
    );
  }
}
