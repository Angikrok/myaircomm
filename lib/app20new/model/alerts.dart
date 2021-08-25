import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

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