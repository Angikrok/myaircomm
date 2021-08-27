import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:flutter/services.dart';
import 'package:my_aircomm/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BarCodeFattura extends StatelessWidget {
  const BarCodeFattura({Key? key, required this.data}) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {
    setBrightness(1);
    return WillPopScope(
      onWillPop: () {
        return resetOrientation();
      },
      child: Scaffold(
        backgroundColor: bluAircomm,
        appBar: AppBar(
          title: Text(
            'Codice a barre per il sistema\n di pagamento digitale',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontFamily: 'Coco'),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: bluAircomm,
          leading: IconButton(
            icon: Icon(Icons.keyboard_return_rounded),
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                //DeviceOrientation.portraitDown,
              ]);
              Navigator.pop(context);
            },
          ),
        ),
        body: InteractiveViewer(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: QrImage(
                          data: data,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SelectableText(
                        data,
                        style: TextStyle(fontFamily: 'Coco'),
                      ),
                    )
                  ],
                )),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          height: 80,
                          child: BarcodeWidget(
                            data: data,
                            drawText: false,
                            barcode: Barcode.code128(
                              useCode128A: true,
                              useCode128B: false,
                              useCode128C: false,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> resetOrientation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);
    return true;
  }
}
