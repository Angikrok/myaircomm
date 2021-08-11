import 'dart:async';
import 'dati_login_aziende.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dati_login_clienti.dart';

class DbHelper {
  static late Database database;
  Future<int> apriDbClienti() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'clienti.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE clienti(id INTEGER PRIMARY KEY, cc TEXT, g TEXT, m TEXT, a TEXT)',
        );
      },
      version: 1,
    );
    return 1;
  }

  Future<int> apriDbAziende() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'aziende.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE aziende(id INTEGER PRIMARY KEY, cc TEXT, cf TEXT)',
        );
      },
      version: 1,
    );
    return 1;
  }

  Future insertDatiClienti(DatiLoginClienti datiLogin) async {
    String cc = datiLogin.cc;
    String g = datiLogin.g;
    String m = datiLogin.m;
    String a = datiLogin.a;

    await database.rawQuery(
        'UPDATE clienti SET cc = "$cc", g = "$g", m = "$m", a = "$a" WHERE id = 1');
  }

  Future insertDatiAziende(DatiLoginAziende datiLoginAziende) async {
    String cc = datiLoginAziende.cc;
    String cf = datiLoginAziende.cf;

    await database
        .rawQuery('UPDATE aziende SET cc = "$cc", cf = "$cf" WHERE id = 1');
  }

  Future ricordaDaticlienti(
      {String? cc, String? g, String? m, String? a}) async {
    DatiLoginClienti dati = await readDatiClienti();
    if (cc != null) {
      dati.cc = cc;
    }
    if (g != null) {
      dati.g = g;
    }
    if (m != null) {
      dati.m = m;
    }
    if (a != null) {
      dati.a = a;
    }
    await insertDatiClienti(dati);
  }

  Future ricordaDatiAziende({String? cc, String? cf}) async {
    DatiLoginAziende dati = await readDatiAziende();
    if (cc != null) {
      dati.cc = cc;
    }
    if (cf != null) {
      dati.cf = cf;
    }
    await insertDatiAziende(dati);
  }

  Future<DatiLoginClienti> readDatiClienti() async {
    List<Map<String, dynamic>> mappaUtente = await database.query('clienti');
    if (mappaUtente.length > 0) {
      DatiLoginClienti datiLogin = DatiLoginClienti.fromMap(mappaUtente[0]);
      return datiLogin;
    } else {
      database.rawQuery(
          'INSERT INTO clienti (id,cc,g,m,a) VALUES (1,"","Giorno","Mese","Anno")');
      return DatiLoginClienti(cc: '', g: 'Giorno', m: 'Mese', a: 'Anno');
    }
  }

  Future<DatiLoginAziende> readDatiAziende() async {
    List<Map<String, dynamic>> mappaAziende = await database.query('aziende');
    if (mappaAziende.length > 0) {
      DatiLoginAziende datiLoginAziende =
          DatiLoginAziende.fromMap(mappaAziende[0]);
      return datiLoginAziende;
    } else {
      database.rawQuery('INSERT INTO aziende (id,cc,cf) VALUES (1,"","")');
      return DatiLoginAziende(cc: '', cf: '');
    }
  }

  Future cancellaDatiClienti() async {
    //await database.delete('clienti');
    await database.rawQuery(
        'UPDATE clienti SET cc = "", g = "Giorno", m = "Mese", a = "Anno" WHERE id = 1');
  }

  Future cancellaDatiAziende() async {
    //await database.delete('aziende');
    await database.rawQuery('UPDATE aziende SET cc = "", cf = "" WHERE id = 1');
  }
}
