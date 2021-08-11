import 'invoice.dart';

class DatiUtenza {
  final String id;
  final String nome;
  final String tipo;
  final String ultimoMese;
  final String prossimaBolletta;
  List<Invoice> not_payed_invoice;

  DatiUtenza({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.ultimoMese,
    required this.prossimaBolletta,
    required this.not_payed_invoice,
  });

  factory DatiUtenza.fromJson(Map<String, dynamic> parsedJson) {
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

    List<Invoice> not_payed_invoice =
        (parsedJson['user_invoice_not_payed'])
            .map<Invoice>((b) => Invoice.fromJson(b))
            .toList();

    return DatiUtenza(
      id: id,
      nome: nome,
      tipo: tipo,
      ultimoMese: ultimoMese,
      prossimaBolletta: prossimaBolletta,
      not_payed_invoice: not_payed_invoice,
    );
  }
}
