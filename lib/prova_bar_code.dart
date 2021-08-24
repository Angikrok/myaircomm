import 'dart:io';
import 'dart:math';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';

class BarCode extends StatefulWidget {
  const BarCode({Key? key}) : super(key: key);

  @override
  _BarCodeState createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
          angle: 90 * pi / 180,
          child: BarcodeWidget(
            drawText: false,
            barcode: Barcode.code128(
              useCode128A: true,
              useCode128B: false,
              useCode128C: false,
            ),
            data: '123123123',
            width: MediaQuery.of(context).size.height,
            height: 80,
          ),
        ),
      ),
    );
  }
}

void buildBarcode(
  Barcode bc,
  String data, {
  String? filename,
  double? width,
  double? height,
  double? fontHeight,
}) {
  /// Create the Barcode
  final svg = bc.toSvg(
    data,
    width: width ?? 200,
    height: height ?? 80,
    fontHeight: fontHeight,
  );

  // Save the image
  filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
  File('$filename.svg').writeAsStringSync(svg);
  buildBarcode(
    Barcode.code128(useCode128B: false, useCode128C: false),
    'BARCODE\t128',
    filename: 'code-128a',
  );
}
