import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart';

import 'package:myaircomm/controller/http_helper.dart';

import 'main.dart';
import 'model/user_info.dart';

HttpHelper helper = HttpHelper();
SharedPreferences? pref;

UserInfo userInfo = UserInfo(
    id: '', name: '', type: '', lastMonth: '', nextInvoice: '', invoice: []);
String? cc;
String? day;
String? month;
String? year;
String? iva;
const Color orange = Color(0xFFfb6600);
const Color blue = Color(0xFF0078e3);
Color grey = const Color(0xff707070);
const Color black = Color(0xff212121);

TextStyle montSerrat(
    {FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    double? letterSpacing,
    FontStyle? fontStyle}) {
  return GoogleFonts.montserrat(
      color: color,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontSize: fontSize);
}

String detectMonth(String nextInvoice) {
  int month = int.parse(nextInvoice);
  if (month == 1) {
    return 'Gennaio';
  } else if (month == 2) {
    return 'Febbraio';
  } else if (month == 3) {
    return 'Marzo';
  } else if (month == 4) {
    return 'Aprile';
  } else if (month == 5) {
    return 'Maggio';
  } else if (month == 6) {
    return 'Giugno';
  } else if (month == 7) {
    return 'Luglio';
  } else if (month == 8) {
    return 'Agosto';
  } else if (month == 9) {
    return 'Settembre';
  } else if (month == 10) {
    return 'Ottobre';
  } else if (month == 11) {
    return 'Novembre';
  } else if (month == 12) {
    return 'Dicembre';
  } else {
    return 'Errore';
  }
}

String data(DateTime data) {
  String currentData = DateFormat("dd/MM/yyyy").format(data);
  return currentData;
}

Future<void> scheduleNotification(int year, int month) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    playSound: true,
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelsSpecifics = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
      android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'MyAircomm',
      'Ciao ${userInfo.name} 👋\nHai appena ricevuto una fattura da Aircomm',
      TZDateTime(
        Location(currentTimeZone, [], [],
            [const TimeZone(1, isDst: true, abbreviation: '')]),
        year,
        month,
        10,
        17,
      ),
      platformChannelsSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: false);
}
