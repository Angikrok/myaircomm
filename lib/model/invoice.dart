class Invoice {
  final String billId;
  final String tot;
  final String data;
  final String barCode;
  final String payDate;

  Invoice(
      {required this.billId,
        required this.tot,
        required this.data,
        required this.barCode,
        required this.payDate});

  factory Invoice.fromJson(Map<String, dynamic> invoice) {
    String idFattura;
    String tot;
    String data;
    String barCodeT;
    String payDate;
    try {
      idFattura = (invoice['ID_FATTURA'] == null)
          ? 'nulla'
          : invoice['ID_FATTURA'].toString();
    } catch (error) {
      idFattura = 'errore';
    }
    try {
      tot =
      (invoice['TOTALE'] == null) ? 'nulla' : invoice['TOTALE'].toString();
    } catch (error) {
      tot = 'errore';
    }
    try {
      data = (invoice['DATA_FATTURA'] == null)
          ? 'nulla'
          : invoice['DATA_FATTURA'].toString();
    } catch (error) {
      data = 'errore';
    }
    try {
      barCodeT = (invoice['BARCODE'] == null)
          ? 'nulla'
          : invoice['BARCODE'].toString();
    } catch (error) {
      barCodeT = 'errore';
    }
    try {
      payDate = (invoice['PAYDATE'] == null)
          ? ''
          : invoice['PAYDATE'].toString();
    } catch (error) {
      payDate = 'errore';
    }
    return Invoice(
      billId: idFattura,
      tot: tot,
      data: data,
      barCode: barCodeT,
      payDate: payDate,
    );
  }
}
