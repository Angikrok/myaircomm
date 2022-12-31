// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../model/invoice.dart';
import '../model/user_info.dart';

class HttpHelper {
  String authority = "core.aircommservizi.it";
  String pathCliente = 'fatture_login_test.php';
  String pathFattura = 'fatture_lista.php';
  String pathAzienda = 'fatture_login_business.php'; 

  Future<bool> check() async {
    Uri url = Uri.http(authority, '');
    try {
      // ignore: unused_local_variable
      Response response = await get(url).timeout(const Duration(seconds: 5));
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

  Future<UserInfo> getDatiCliente(
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

      UserInfo datiCliente =
          data.map<UserInfo>((e) => UserInfo.fromJson(e)).toList().first;

      return datiCliente;
    }
    throw Exception('Errore response != 200');
  }

  Future<UserInfo> getDatiAzienda(
    String cc,
    String cf,
  ) async {
    Map<String, dynamic> parameters = {'cc': cc, 'cf': cf};
    Uri url = Uri.http(authority, pathAzienda, parameters);
    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List dati = jsonResponse['data'];
      UserInfo datiAziende =
          dati.map<UserInfo>((e) => UserInfo.fromJson(e)).toList().first;
      return datiAziende;
    } else {
      throw Exception('Errore response != 200');
    }
  }

  Future<List<Invoice>> storicoFatture(String cc, String anno) async {
    Map<String, dynamic> parameters = {'cc': cc, 'a': anno};
    Uri url = Uri.http(
      authority,
      pathFattura,
      parameters,
    );

    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List dati = jsonResponse['user_invoice_history'];
      List<Invoice> storicoFatture =
          dati.map<Invoice>((e) => Invoice.fromJson(e)).toList();
      return storicoFatture;
    } else {
      return [];
    }
  }
}
