//  ignore_for_file: must_be_immutable

// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:myaircomm/constants.dart';
// import 'package:myaircomm/model/widget/custombody.dart';

// class EnterModule extends StatefulWidget {
//   const EnterModule({super.key});

//   @override
//   State<EnterModule> createState() => _EnterModuleState();
// }

// class _EnterModuleState extends State<EnterModule> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: CustomBody(
//         horizontalSpace: true,
//         verticalSpace: true,
//         child: SafeArea(
//           child: Column(
//             children: [
//               Image.asset(
//                 "assets/images/logo.png",
//                 height: 200,
//               ),
//               Text(
//                 textAlign: TextAlign.center,
//                 "Vorresti usufruire del nostro servizio in qualità di privato o azienda?",
//                 style: montSerrat(
//                     color: grey, fontSize: 20, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 50),
//               mainfilter(),
//               const Spacer(),
//               Row(
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: blue,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20))),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         "Torna al login",
//                         style: montSerrat(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       )),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget mainfilter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (c) => Module(
//                           isPrivate: true,
//                         )));
//           },
//           child: Column(
//             children: [
//               Container(
//                   decoration: BoxDecoration(
//                     color: blue,
//                     border: Border.all(color: blue, width: 1),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.all(15),
//                   child: const Icon(Iconsax.profile_circle,
//                       size: 60, color: Colors.white)),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Text("Privato",
//                     style: montSerrat(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: black)),
//               )
//             ],
//           ),
//         ),
//         const SizedBox(width: 40),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (c) => Module(
//                           isPrivate: false,
//                         )));
//           },
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: blue,
//                   border: Border.all(color: blue, width: 1),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: const EdgeInsets.all(15),
//                 child: const Icon(Iconsax.buildings,
//                     size: 60, color: Colors.white),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Text("Aziendale",
//                     style: montSerrat(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: black,
//                     )),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Module extends StatefulWidget {
//   bool isPrivate;
//   Module({super.key, this.isPrivate = true});

//   @override
//   State<Module> createState() => _ModuleState();
// }

// class _ModuleState extends State<Module> {
//   int installType = 0;
//   int modePayment = 0;
//   int paymentType = 0;
//   bool isChecked = true;
//   File? frontImage;
//   File? backImage;

//   TextEditingController businesNameController = TextEditingController();
//   TextEditingController businesSubnameController = TextEditingController();
//   TextEditingController businesRagioneSociale = TextEditingController();
//   TextEditingController businesIvaController = TextEditingController();
//   TextEditingController businesTelephone = TextEditingController();
//   TextEditingController businesComuneFatturazione = TextEditingController();
//   TextEditingController businesComuneInstallazione = TextEditingController();
//   TextEditingController businesIndirizzoInstallazione = TextEditingController();
//   TextEditingController businesIndirizzoFatturazione = TextEditingController();
//   TextEditingController businesEmail = TextEditingController();
//   TextEditingController businesIban = TextEditingController();
//   TextEditingController businesNote = TextEditingController();
//   TextEditingController businesCodiceUnivoco = TextEditingController();
//   bool isComplete = false;
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: CustomBody(
//           horizontalSpace: true,
//           verticalSpace: false,
//           child: ListView(children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     setState(() {});
//                   },
//                   icon: const Icon(
//                     CupertinoIcons.back,
//                     size: 30,
//                   ),
//                 ),
//                 Text(
//                   widget.isPrivate ? 'Modulo privato' : 'Modulo aziendale',
//                   style: montSerrat(fontSize: 22, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             Image.asset(
//               "assets/images/logo.png",
//               height: 200,
//             ),
//             Row(
//               children: const [
//                 Spacer(),
//               ],
//             ),
//             //Inserire filtri
//             const SizedBox(height: 20),
//             screenbusiness(context),
//           ])),
//     );
//   }

//   Column screenbusiness(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           "Modulo di richeista",
//           style: montSerrat(
//               color: black.withOpacity(0.8),
//               fontSize: 24,
//               fontWeight: FontWeight.w600),
//         ),
//         Row(
//           children: [
//             datacontainer(
//               MediaQuery.of(context).size.width / 2.8,
//               businesNameController,
//               "Nome",
//             ),
//             const SizedBox(width: 15),
//             datacontainer(
//               MediaQuery.of(context).size.width / 2.8,
//               businesSubnameController,
//               "Cognome",
//             ),
//           ],
//         ),
//         widget.isPrivate
//             ? Container()
//             : datacontainer(
//                 MediaQuery.of(context).size.width,
//                 businesCodiceUnivoco,
//                 "Codice univoco",
//               ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             widget.isPrivate
//                 ? Container()
//                 : datacontainer(
//                     MediaQuery.of(context).size.width,
//                     businesIvaController,
//                     "Partita IVA",
//                   ),
//             Row(
//               children: [
//                 datacontainer(
//                   MediaQuery.of(context).size.width / 1.5,
//                   businesTelephone,
//                   "Recapito Telefonico",
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text('Foto tessera sanitaria intestatario\n'),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     const Text('Fronte'),
//                     GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (c) => Column(
//                                   children: [
//                                     ListTile(
//                                       onTap: () {
//                                         pickImage(ImageSource.camera, true);
//                                       },
//                                       leading: const CircleAvatar(
//                                         backgroundColor: blue,
//                                         child: Icon(
//                                           Iconsax.camera,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       title: Text(
//                                         'Scatta foto',
//                                         style: montSerrat(),
//                                       ),
//                                     ),
//                                     ListTile(
//                                       onTap: () {
//                                         pickImage(ImageSource.gallery, true);
//                                       },
//                                       leading: const CircleAvatar(
//                                         backgroundColor: orange,
//                                         child: Icon(
//                                           Iconsax.gallery,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       title: Text(
//                                         'Scegli dalla Galleria',
//                                         style: montSerrat(),
//                                       ),
//                                     ),
//                                   ],
//                                 ));
//                       },
//                       child: Container(
//                           width: MediaQuery.of(context).size.width / 2.3,
//                           height: 100,
//                           margin: const EdgeInsets.only(top: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: frontImage == null
//                               ? const Center(
//                                   child: Icon(Iconsax.add_circle),
//                                 )
//                               : ClipRRect(
//                                   borderRadius: BorderRadius.circular(14),
//                                   child: Image.file(
//                                     frontImage!,
//                                     fit: BoxFit.cover,
//                                   ))),
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     const Text('Retro'),
//                     GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (c) => Column(
//                                   children: [
//                                     ListTile(
//                                       onTap: () {
//                                         pickImage(ImageSource.camera, false);
//                                       },
//                                       leading: const CircleAvatar(
//                                         backgroundColor: blue,
//                                         child: Icon(
//                                           Iconsax.camera,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       title: Text(
//                                         'Scatta foto',
//                                         style: montSerrat(),
//                                       ),
//                                     ),
//                                     ListTile(
//                                       onTap: () {
//                                         pickImage(ImageSource.gallery, false);
//                                       },
//                                       leading: const CircleAvatar(
//                                         backgroundColor: orange,
//                                         child: Icon(
//                                           Iconsax.gallery,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       title: Text(
//                                         'Scegli dalla Galleria',
//                                         style: montSerrat(),
//                                       ),
//                                     ),
//                                   ],
//                                 ));
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width / 2.3,
//                         height: 100,
//                         margin: const EdgeInsets.only(top: 4, left: 12),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: Colors.white),
//                             child: backImage == null
//                               ? const Center(
//                                   child: Icon(Iconsax.add_circle),
//                                 )
//                               : ClipRRect(
//                                   borderRadius: BorderRadius.circular(14),
//                                   child: Image.file(
//                                     backImage!,
//                                     fit: BoxFit.cover,
//                                   )),
                                
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             datacontainer(
//               MediaQuery.of(context).size.width,
//               businesComuneInstallazione,
//               "Comune di installazione",
//             ),
//             datacontainer(
//               MediaQuery.of(context).size.width,
//               businesIndirizzoInstallazione,
//               "Indirizzo di installazione",
//             ),
//             Row(
//               children: [
//                 const Spacer(),
//                 Text(
//                   "Usa stesso indirizzo per fatturazione",
//                   style: montSerrat(
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                     color: black,
//                   ),
//                 ),
//                 Checkbox(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(7)),
//                   checkColor: Colors.white,
//                   fillColor: const MaterialStatePropertyAll(blue),
//                   value: isChecked,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isChecked = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             !isChecked
//                 ? datacontainer(
//                     MediaQuery.of(context).size.width,
//                     businesComuneFatturazione,
//                     "Comune di fatturazione",
//                   )
//                 : Container(),
//             !isChecked
//                 ? datacontainer(
//                     MediaQuery.of(context).size.width,
//                     businesIndirizzoFatturazione,
//                     "Indirizzo di fatturazione",
//                   )
//                 : Container(),
//             datacontainer(
//               MediaQuery.of(context).size.width,
//               businesEmail,
//               "Email",
//             ),
//             datacontainer(
//               MediaQuery.of(context).size.width,
//               businesIban,
//               "IBAN",
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Tipo di installazione",
//               style: montSerrat(color: black, fontSize: 20),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     installType = 1;
//                     setState(() {});
//                   },
//                   child: datafilter(1, "Cpe"),
//                 ),
//                 const SizedBox(width: 15),
//                 GestureDetector(
//                     onTap: () {
//                       installType = 2;
//                       setState(() {});
//                     },
//                     child: datafilter(2, "Fibra")),
//                 const SizedBox(width: 15),
//                 GestureDetector(
//                     onTap: () {
//                       installType = 3;
//                       setState(() {});
//                     },
//                     child: datafilter(3, "Con Telefono")),
//               ],
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//                 onTap: () {
//                   installType = 4;
//                   setState(() {});
//                 },
//                 child: datafilter(4, "Con Portabilità")),
//             const SizedBox(height: 20),
//             Text(
//               "Modalità di pagamento",
//               style: montSerrat(color: black, fontSize: 20),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                     onTap: () {
//                       modePayment = 2;
//                       setState(() {});
//                     },
//                     child: datafilter2(2, "Rid")),
//                 const SizedBox(width: 15),
//                 GestureDetector(
//                     onTap: () {
//                       modePayment = 3;
//                       setState(() {});
//                     },
//                     child: datafilter2(3, "SID")),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Tipologia di Pagamento",
//               style: montSerrat(color: black, fontSize: 20),
//             ),
//             Wrap(
//               children: [
//                 GestureDetector(
//                     onTap: () {
//                       paymentType = 1;
//                       setState(() {});
//                     },
//                     child: datafilter3(1, "Bimestrale")),
//                 const SizedBox(width: 15),
//                 GestureDetector(
//                     onTap: () {
//                       paymentType = 2;
//                       setState(() {});
//                     },
//                     child: datafilter3(2, "Semestrale")),
//                 const SizedBox(width: 15),
//                 GestureDetector(
//                     onTap: () {
//                       paymentType = 4;
//                       setState(() {});
//                     },
//                     child: datafilter3(4, "Annuale")),
//                 GestureDetector(
//                     onTap: () {
//                       paymentType = 5;
//                       setState(() {});
//                     },
//                     child: datafilter3(5, "Mensile")),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Note",
//               style: montSerrat(color: black, fontSize: 20),
//             ),
//             note()
//           ],
//         ),
//         Row(
//           children: [
//             const Spacer(),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.only(
//                         top: 10, bottom: 10, left: 20, right: 20),
//                     backgroundColor: blue,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15))),
//                 onPressed: () {
//                   _showquestion();
//                 },
//                 child: Text(
//                   "Invia Richiesta",
//                   style: montSerrat(fontSize: 18, fontWeight: FontWeight.w600),
//                 ))
//           ],
//         )
//       ],
//     );
//   }

//   Container datafilter(int number, String type) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: installType == number ? blue : grey,
//               width: installType == number ? 2 : 1),
//           borderRadius: BorderRadius.circular(10)),
//       child: Text(
//         type,
//         style: montSerrat(color: grey, fontSize: 18),
//       ),
//     );
//   }

//   Container datafilter2(int number, String type) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: modePayment == number ? blue : grey,
//               width: modePayment == number ? 2 : 1),
//           borderRadius: BorderRadius.circular(10)),
//       child: Text(
//         type,
//         style: montSerrat(color: grey, fontSize: 18),
//       ),
//     );
//   }

//   Container datafilter3(int number, String type) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 5, top: 10),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: paymentType == number ? blue : grey,
//               width: paymentType == number ? 2 : 1),
//           borderRadius: BorderRadius.circular(10)),
//       child: Text(
//         type,
//         style: montSerrat(color: grey, fontSize: 18),
//       ),
//     );
//   }

//   Widget datacontainer(
//       double width, TextEditingController controller, String? txt) {
//     return Container(
//         margin: const EdgeInsets.only(top: 15),
//         width: width,
//         child: TextField(
//           expands: false,
//           maxLines: 5,
//           minLines: 1,
//           cursorHeight: 15,
//           controller: controller,
//           cursorColor: black,
//           decoration: InputDecoration(
//             focusColor: orange,
//             hintText: txt,
//             contentPadding: const EdgeInsets.all(10),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: grey),
//                 borderRadius: BorderRadius.circular(10)),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: blue, width: 1.5),
//             ),
//           ),
//         ));
//   }

//   Widget note() {
//     return Container(
//       margin: const EdgeInsets.only(top: 10, bottom: 30),
//       child: TextField(
//         cursorColor: black,
//         maxLines: 5,
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: blue, width: 1.5)),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           filled: false,
//         ),
//       ),
//     );
//   }

//   Future<void> _showquestion() async {
//     bool isYes = false;
//     bool isNo = true;
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, dialogSetState) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//             content: Text(
//               "Sei stato invitato da qualcuno?",
//               style: montSerrat(fontSize: 16, color: grey),
//             ),
//             actions: <Widget>[
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         "SI",
//                         style: montSerrat(color: black, fontSize: 18),
//                       ),
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7)),
//                         checkColor: Colors.white,
//                         fillColor: const MaterialStatePropertyAll(blue),
//                         value: isYes,
//                         onChanged: (bool? value) {
//                           dialogSetState(() {
//                             isYes = value!;
//                             if (value == false) {
//                               isNo = true;
//                             } else {
//                               isNo = false;
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "NO",
//                         style: montSerrat(color: black, fontSize: 18),
//                       ),
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7)),
//                         checkColor: Colors.white,
//                         fillColor: const MaterialStatePropertyAll(blue),
//                         value: isNo,
//                         onChanged: (bool? value) {
//                           dialogSetState(() {
//                             isNo = value!;
//                             if (value == false) {
//                               isYes = true;
//                             } else {
//                               isYes = false;
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 18),
//                 child: Row(
//                   children: [
//                     isYes
//                         ? Column(
//                             children: [
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width / 2,
//                                 child: TextField(
//                                     textAlignVertical: TextAlignVertical.center,
//                                     cursorColor: black,
//                                     decoration: InputDecoration(
//                                         hintText: "Inserisci l'agente",
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                             borderSide: const BorderSide(
//                                               width: .2,
//                                             )))),
//                               ),
//                             ],
//                           )
//                         : Container(),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 child: Text(
//                   'Ok',
//                   style: montSerrat(
//                       fontSize: 18, color: blue, fontWeight: FontWeight.bold),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }

//   Future pickImage(ImageSource imageSource, bool isFront) async {
//     XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
//     if (pickedFile != null) {
//       setState(() {
//         isFront
//             ? frontImage = File(pickedFile.path)
//             : backImage = File(pickedFile.path);
//       });
//     }
//   }
// }
