import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'screens/logged/menu.dart';
import 'screens/login/login.dart';

late final String currentTimeZone;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  var inizialitationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var inizialitationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (id, title, body, payload) async {},
  );
  var initialzationSettings = InitializationSettings(
      android: inizialitationSettingsAndroid, iOS: inizialitationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initialzationSettings);

  pref = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<InternetConnectionStatus>(
      initialData: InternetConnectionStatus.connected,
      create: (_) {
        return InternetConnectionChecker().onStatusChange;
      },
      child: MaterialApp(
          localeListResolutionCallback: (locales, supportedLocales) {
            for (Locale locale in locales!) {
              if (supportedLocales.contains(locale)) {
                return locale;
              }
            }

            return const Locale('it', 'IT');
          },
          // localizationsDelegates: [],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('it')],
          locale: const Locale('it'),
          debugShowCheckedModeBanner: false,
          title: 'MyAircomm',
          theme: ThemeData(),
          darkTheme: ThemeData(),
          // home: const EnterModule(),
          home: pref!.getString('cc') == null || pref!.getString('cc') == ''
              ? const Login()
              : Menu(index: 0)),
    );
  }
}
