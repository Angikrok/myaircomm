// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:myaircomm/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BillPdf extends StatefulWidget {
  String billId;
  BillPdf({required this.billId, Key? key}) : super(key: key);

  @override
  State<BillPdf> createState() => _BillPdfState();
}

class _BillPdfState extends State<BillPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Stack(
          children: [
            SfPdfViewer.network(
                'http://core.aircommservizi.it/admin/a/pdf.php?id=${widget.billId}',
                canShowPaginationDialog: false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: blue.withOpacity(0.8)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(CupertinoIcons.back, color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: blue.withOpacity(0.85)),
                    child: IconButton(
                      onPressed: () {
                        Share.share(
                            'http://core.aircommservizi.it/admin/a/pdf.php?id=${widget.billId}');
                      },
                      icon: const Icon(CupertinoIcons.share, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
