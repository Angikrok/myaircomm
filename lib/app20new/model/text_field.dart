// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '/app20new/model/alerts.dart';

class FieldDate extends StatelessWidget {
  FieldDate(
      {Key? key,
      required this.validate,
      required this.txt,
      required this.formKey,
      required this.controller})
      : super(key: key);
  bool validate = false;
  final String txt;
  GlobalKey<FormState> formKey;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Questo campo\n è obbligatorio';
            }
            return null;
          },
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontSize: 12),
            hintText: txt,
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}

class TextAccess extends StatelessWidget {
  TextAccess({
    required this.text,
    Key? key,
  }) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Italico'),
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
      padding: const EdgeInsets.only(right: 16, left: 16),
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
          hintText: txt,
          suffixIcon: GestureDetector(
            onTap: () {
              showAlertDialog(context);
              //metodo del popup
            },
            child: Icon(
              LineIcons.flag,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
