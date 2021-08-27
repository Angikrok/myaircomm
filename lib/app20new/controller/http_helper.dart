import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';

class HttpHelper {
  String authority = "core.aircommservizi.it";
  String pathCliente = 'fatture_login_test.php';
  String pathFattura = 'fatture_lista.php';
  String pathAzienda = 'fatture_login_business.php';
  String pathPdf = 'admin/a/pdf.php';

  Future<bool> check() async {
    Uri url = Uri.http(authority, '');
    try {
      // ignore: unused_local_variable
      Response response = await get(url).timeout(Duration(seconds: 5));
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> serviceStatus() async {
    Uri url = Uri.http(authority, 'status.php');
    Response response = await get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<DatiUtenza> getDatiCliente(
    String cc,
    String giorno,
    String mese,
    String anno,
  ) async {
    Map<String, dynamic> parameters = {
      'cc': cc,
      'g': giorno,
      'm': mese,
      'a': anno
    };

    Uri url = Uri.http(authority, pathCliente, parameters);
    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List data = jsonResponse['data'];

      DatiUtenza datiCliente =
          data.map<DatiUtenza>((e) => DatiUtenza.fromJson(e)).toList().first;

      return datiCliente;
    }
    throw Exception('Errore response != 200');
  }

  Future<DatiUtenza> getDatiAzienda(
    String cc,
    String cf,
  ) async {
    Map<String, dynamic> parameters = {'cc': cc, 'cf': cf};
    Uri url = Uri.http(authority, pathAzienda, parameters);
    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List dati = jsonResponse['data'];
      DatiUtenza datiAziende =
          dati.map<DatiUtenza>((e) => DatiUtenza.fromJson(e)).toList().first;
      return datiAziende;
    } else
      throw Exception('Errore response != 200');
  }

  Future<List<Invoice>> storicoFatture(String cc, String anno) async {
    Map<String, dynamic> parameters = {'cc': cc, 'a': anno};
    Uri url = Uri.http(
      authority,
      pathFattura,
      parameters,
    );
    bool internet = true;
    if (internetChecker(internet) == true) {
      Response response = await get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List dati = jsonResponse['user_invoice_history'];
        List<Invoice> storicoFatture =
            dati.map<Invoice>((e) => Invoice.fromJson(e)).toList();
        return storicoFatture;
      } else
        return [];
    } else {
      throw Exception('Nessuna Connessione a internet');
    }
  }

  bool internetChecker(bool internet)  {
    InternetConnectionChecker().onStatusChange.listen((event) {
      //hasInternet è un bool che serve a capire lo status della connessione. vero connessione ok falso non connesso
      final hasInternet = event == InternetConnectionStatus.connected;

      internet = true;

      //se è connesso procedi ai test successivi se no torna errore
      if (hasInternet) {
        print('cellulare online: passo alla fase successiva');
        internet = true;
      } else {
        internet = false;
      }
    });
    return internet;
  }
}
