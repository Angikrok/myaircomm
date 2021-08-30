import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:share_plus/share_plus.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key, required this.id}) : super(key: key);
  @override
  _PdfViewState createState() => _PdfViewState();
  final String id;
}

class _PdfViewState extends State<PdfView> {
  bool _isLoading = true;
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
        'http://core.aircommservizi.it/admin/a/pdf.php?id=${widget.id}');

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_return_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        backgroundColor: bluAircomm,
        title: Text('ID Fattura: ' + widget.id),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: Lottie.asset(
                'assets/icon/loadingList.json',
              ),
            )
          : SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      24,
                    ),
                  ),
                  color: bluAircomm,
                ),
                child: PDFViewer(
                  progressIndicator: Lottie.asset(
                    'assets/icon/loadingList.json',
                  ),
                  indicatorText: Colors.white,
                  showPicker: false,
                  showNavigation: true,
                  indicatorPosition: IndicatorPosition.topRight,
                  scrollDirection: Axis.horizontal,
                  document: document!,
                  zoomSteps: 1,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          share(context, document.toString());

          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00b4d8),
                  Colors.blue,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: Icon(
            Icons.share,
          ),
        ),
      ),
    );
  }

  void share(BuildContext context, String file) {
    String message =
        'http://core.aircommservizi.it/admin/a/pdf.php?id=${widget.id}';
    RenderBox? box = context.findRenderObject() as RenderBox;
    Share.share(message,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
