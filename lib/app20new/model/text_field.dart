// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextAccess extends StatelessWidget {
  TextAccess({
    required this.text,
    Key? key,
  }) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TextField_Cc extends StatelessWidget {
  const TextField_Cc({
    Key? key,
    required this.txtCC,
    required this.txt,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController txtCC;

  final String txt;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Questo campo è obbligatorio';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: txtCC,
        decoration: InputDecoration(
          labelText: txt,
          suffixIcon: Icon(
            Icons.accessibility_sharp,
          ),
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
