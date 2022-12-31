import 'invoice.dart';

class UserInfo {
  final String id;
  final String name;
  final String type;
  final String lastMonth;
  final String nextInvoice;
  List<Invoice> invoice;

  UserInfo({
    required this.id,
    required this.name,
    required this.type,
    required this.lastMonth,
    required this.nextInvoice,
    required this.invoice,
  });

  factory UserInfo.fromJson(Map<String, dynamic> parsedJson) {
    String id;
    String nome;
    String tipo;
    String ultimoMese;
    String prossimaBolletta;
    try {
      id = (parsedJson['user_detail']['id'] == null)
          ? 'nulla'
          : parsedJson['user_detail']['id'].toString();
    } catch (error) {
      id = 'errore';
    }
    try {
      nome = (parsedJson['user_detail']['nome_cognome'] == null)
          ? 'nulla'
          : parsedJson['user_detail']['nome_cognome'].toString();
    } catch (error) {
      nome = 'errore';
    }

    try {
      tipo = (parsedJson['user_detail']['tipo_bolletta'] == null)
          ? 'nulla'
          : parsedJson['user_detail']['tipo_bolletta'].toString();
    } catch (error) {
      tipo = 'errore';
    }

    try {
      ultimoMese = (parsedJson['user_detail']['ultimo_mese'] == null)
          ? 'nulla'
          : parsedJson['user_detail']['ultimo_mese'].toString();
    } catch (error) {
      ultimoMese = 'errore';
    }

    try {
      prossimaBolletta =
      (parsedJson['user_detail']['prossima_bolletta'] == null)
          ? 'nulla'
          : parsedJson['user_detail']['prossima_bolletta'].toString();
    } catch (error) {
      prossimaBolletta = 'errore';
    }

    List<Invoice> invoice = (parsedJson['user_invoice_not_payed'])
        .map<Invoice>((b) => Invoice.fromJson(b))
        .toList();

    return UserInfo(
      id: id,
      name: nome,
      type: tipo,
      lastMonth: ultimoMese,
      nextInvoice: prossimaBolletta,
      invoice: invoice,
    );
  }
}
