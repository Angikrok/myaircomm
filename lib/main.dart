import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_aircomm/app20new/screen/01_loadingscreen/home_screen.dart';
import 'package:screen_brightness/screen_brightness.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Aircomm',
      theme: ThemeData(fontFamily: 'Coco'),
      darkTheme: ThemeData(),
      home: HomeScreen(),
    );
  }
}
// try {
//     StoreLauncher.openWithStore('com.criptoconio.myaircomm').catchError((e) {
//       print('ERROR> $e');
//     });
//   } on Exception catch (e) {
//     print('$e');
//   }

//StreamBuilder
Future<void> setBrightness(double brightness) async {
  try {
    await ScreenBrightness.setScreenBrightness(brightness);
  } catch (e) {
    print(e);
    throw 'Failed to set brightness';
  }
}
