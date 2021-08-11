import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.txt, required this.child})
      : super(key: key);
  final String txt;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            PageTransition(child: child, type: PageTransitionType.fade));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white),
            top: BorderSide(color: Colors.white),
            left: BorderSide(color: Colors.white),
            right: BorderSide(color: Colors.white),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFF0090f7),
              Color(0xFF48bfe3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
