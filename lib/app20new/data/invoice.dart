class Invoice {
  final String id_fattura;
  final String tot;
  final String data;
  final String barCode;

  Invoice(
      {required this.id_fattura,
      required this.tot,
      required this.data,
      required this.barCode});

  factory Invoice.fromJson(Map<String, dynamic> invoice) {
    String id_fattura;
    String tot;
    String data;
    String barCodeT;
    try {
      id_fattura = (invoice['ID_FATTURA'] == null)
          ? 'nulla'
          : invoice['ID_FATTURA'].toString();
    } catch (error) {
      id_fattura = 'errore';
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
    return Invoice(
      id_fattura: id_fattura,
      tot: tot,
      data: data,
      barCode: barCodeT,
    );
  }
}
