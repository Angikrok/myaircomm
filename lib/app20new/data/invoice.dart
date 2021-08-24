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
    String barCode;
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
      barCode = (invoice['BARCODE'] == null)
          ? 'nulla'
          : invoice['BARCODE'].toString();
    } catch (error) {
      barCode = 'errore';
    }

    return Invoice(id_fattura: id_fattura, tot: tot, data: data, barCode: barCode);
  }
}
