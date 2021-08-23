import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'costanti.dart';

showAlertDialog(BuildContext context) {
  CoolAlert.show(
    cancelBtnText: '',
    showCancelBtn: true,
    animType: CoolAlertAnimType.scale,
    title: 'Dove Trovare Il Codice Cliente',
    confirmBtnText: 'Ho capito',
    
    backgroundColor: Colors.transparent,
    context: context,
    type: CoolAlertType.info,
    confirmBtnColor: Color(0xFF023e8a),
    text:
        "Il codice cliente lo può trovare nel contratto o nella sua fattura sempre posizionato in alto a sinistra. \n Il suo codice coincide con l'anno di installazione seguito dal codice AIR.\n Ad esempio il signor Mario Rossi installato nel 2018 avrà il codice cliente composto da 2018AIRxxxx dove x sta all'identificatiivo del suo codice cliente",
  );
}

backButton(BuildContext context) {
  CoolAlert.show(
    cancelBtnText: 'Annulla',
    showCancelBtn: true,
    animType: CoolAlertAnimType.slideInRight,
    title: "Vuoi uscire dall'app?",
    confirmBtnText: "Esci",
    flareAnimationName: 'play',
    backgroundColor: Colors.transparent,
    context: context,
    onConfirmBtnTap: () {
      SystemNavigator.pop();
    },
    onCancelBtnTap: () => Navigator.of(context).pop(false),
    type: CoolAlertType.error,
    confirmBtnColor: Colors.red,
  );
  return Future(() => false);


  
}
Future<bool> onWillPop(DateTime? backButtonPressedTime) async {
    DateTime currentTime = DateTime.now();
    bool backButton;
    backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 2);
    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Clicca di nuovo per chiudere l'app",
          backgroundColor: arancioneAircomm,
          textColor: Colors.white);
      return false;
    }
    SystemNavigator.pop();
    return true;
  }