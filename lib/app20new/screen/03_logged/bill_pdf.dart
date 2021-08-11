import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24)),
                  gradient: LinearGradient(
                      colors: [Color(0xFF00b4d8), Colors.blue[900]!])),
              child: AppBar(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                )),
                backgroundColor: Colors.transparent,
                title: Text('ID Fattura: ' + widget.id),
                centerTitle: true,
              ),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 50)),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: PDFViewer(
                  indicatorText: Colors.white,
                  showPicker: false,
                  showNavigation: false,
                  scrollDirection: Axis.vertical,
                  document: document!,
                  zoomSteps: 1,
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
      ),
    );
  }

  void share(BuildContext context, String file) {
    String message =
        'http://core.aircommservizi.it/admin/a/pdf.php?id=${widget.id}│';
    RenderBox? box = context.findRenderObject() as RenderBox;
    Share.share(message,
        subject: '',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
