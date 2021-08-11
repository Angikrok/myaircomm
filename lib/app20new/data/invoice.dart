class Invoice {
  final String id_fattura;
  final String tot;
  final String data;

  Invoice(
      {required this.id_fattura, required this.tot, required this.data});

  factory Invoice.fromJson(Map<String, dynamic> invoice) {
    String id_fattura;
    String tot;
    String data;
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

    return Invoice(id_fattura: id_fattura, tot: tot, data: data);
  }
}
