import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/screen/01_loadingscreen/elementi_loading_screen/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../fatture_screen/fatture_screen.dart';
import 'storico_fatture.dart';

// ignore: must_be_immutable
class ElementiMenu extends StatefulWidget {
  ElementiMenu({
    Key? key,
    required this.width,
    required this.height,
    required this.datiUtenza,
  }) : super(key: key);

  final double width;
  final double height;
  DatiUtenza datiUtenza;

  @override
  State<ElementiMenu> createState() => _ElementiMenuState();
}

class _ElementiMenuState extends State<ElementiMenu> {
  @override
  Widget build(BuildContext context) {
    DatiUtenza dati = widget.datiUtenza;
    return Container(
      width: widget.width / 1.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          color: Colors.white.withOpacity(.905)),
      child: Stack(
        children: [
          Positioned(
            top: -widget.height / 6,
            right: MediaQuery.of(context).size.width / 2,
            child: CircleAvatar(
              radius: 135,
              backgroundColor: Color(0xFF40b6c7),
            ),
          ),
          Positioned(
            top: widget.height / 1.3,
            left: MediaQuery.of(context).size.width / 2.2,
            child: CircleAvatar(
              radius: 140,
              backgroundColor: Color(0xFF023e8a),
            ),
          ),
          Positioned(
            top: 25,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: widget.height / 1.3,
            left: MediaQuery.of(context).size.width / 2,
            child: Transform.rotate(
              angle: -20,
              child: CircleAvatar(
                radius: 155,
                backgroundColor: Color(0xFF40b6c7),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  immagine(),
                  // tastoAggiungiFoto(context),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //Nome Cliente
              Text(
                dati.nome,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Divider(),
              tastsoFattureNonPagate(context, dati),
              Divider(),
              tastoStorico(context, dati),
              Divider(),
              tastoEsci(context),
              Divider(),
            ],
          )
        ],
      ),
    );
  }

  Container immagine() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white.withOpacity(0.5),
              offset: const Offset(2.0, 4.0),
              blurRadius: 8),
        ],
      ),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(60.0)),
          child: Icon(
            Icons.person_rounded,
            size: 120,
          )),
    );
  }

  ListTile tastsoFattureNonPagate(BuildContext context, DatiUtenza dati) {
    return ListTile(
      trailing: Icon(
        Icons.payment,
        color: Color(0xFFfb8500),
      ),
      title: Text(
        'Fatture da pagare',
        style: TextStyle(
          color: Color(0xFFfb8500),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              child: FattureScreen(
                datiUtenza: widget.datiUtenza,
              ),
              type: PageTransitionType.fade),
        );
      },
    );
  }

  ListTile tastoStorico(BuildContext context, DatiUtenza dati) {
    return ListTile(
      trailing: Icon(
        Icons.payment,
        color: Color(0xFF2d00f7),
      ),
      title: Text(
        'Fattura pagate',
        style: TextStyle(
          color: Color(0xFF2d00f7),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: StoricoFatture(
              datiUtenza: widget.datiUtenza,
              cC: dati.id,
              a: 'Anno',
            ),
            type: PageTransitionType.fade,
          ),
        );
      },
    );
  }

  ListTile tastoEsci(BuildContext context) {
    return ListTile(
      trailing: Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: Text(
        'Esci',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomeScreen(),
                type: PageTransitionType.leftToRight));
      },
    );
  }
}
//   Widget bottomSheet() {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Scegli foto profio'),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton.icon(
//                 onPressed: () {
//                   // pickImage(ImageSource.camera);
//                 },
//                 icon: Icon(Icons.camera),
//                 label: Text('Camera'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextButton.icon(
//                   onPressed: () {
//                     // pickImage(ImageSource.gallery);
//                   },
//                   icon: Icon(Icons.image),
//                   label: Text('Galleria'),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
