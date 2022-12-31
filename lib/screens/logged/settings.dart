// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myaircomm/constants.dart';
import 'package:myaircomm/model/widget/custombody.dart';
import 'package:myaircomm/screens/logged/billing_info.dart';
import 'package:myaircomm/screens/login/login.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationIsActive = true;
  @override
  void initState() {
    if (pref!.getBool('notifications') == null) {
      pref!.setBool('notifications', true);
    } else {
      print(pref!.getBool('notifications')!);
      notificationIsActive = pref!.getBool('notifications')!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      horizontalSpace: true,
      verticalSpace: true,
      child: ListView(
        children: [
          Text(
            "Impostazioni",
            style: montSerrat(
                color: black, fontSize: 28, fontWeight: FontWeight.w700),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: blue,
                    radius: 30,
                    child: Icon(
                      Iconsax.profile_tick5,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 165,
                        child: Text(
                          userInfo.name,
                          style: montSerrat(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        pref!.setString('cc', '');
                        pref!.setInt('isPrivate', 0);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      icon: const Icon(
                        Iconsax.logout,
                        color: Colors.red,
                      ))
                ],
              )),
          Divider(
            color: Colors.black.withOpacity(.4),
            height: 50,
            thickness: .5,
          ),
          const SizedBox(height: 20),
          settingsWidget('Info fatturazione', Iconsax.info_circle, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const BillingInfo()));
          }, false),
          settingsWidget('Privacy policy', Iconsax.shield_tick, () async {
            String url = "https://www.aircomm.it/privacy.html";
    
            await launchUrlString(url, mode: LaunchMode.inAppWebView);
          }, false),
          settingsWidget('Condividi app', Iconsax.share, () async {
            if (Platform.isAndroid || Platform.isIOS) {
              final link = Platform.isAndroid
                  ? "https://play.google.com/store/apps/details?id=com.criptoconio.myaircomm"
                  : 'https://apps.apple.com/it/app/myaircom/id161465610';
              Share.share(link);
            }
          }, false),
          settingsWidget('Notifiche', Iconsax.notification, () {}, true),
        ],
      ),
    );
  }

  ListTile settingsWidget(
      String title, IconData icon, Function function, bool notification) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 3, right: 3),
      onTap: () {
        function();
      },
      minLeadingWidth: 20,
      title: Text(
        title,
        style: montSerrat(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),
      ),
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      trailing: notification
          ? Switch.adaptive(
              value: notificationIsActive,
              onChanged: (value) async {
                notificationIsActive = !notificationIsActive;
                await pref!.setBool('notifications', notificationIsActive);
                if (notificationIsActive == false) {
                  await flutterLocalNotificationsPlugin
                      .cancelAll()
                      .then((value) {
                    print('Notifiche disattivate');
                  });
                } else {
                  print("Notifiche attivate");
                }
                setState(() {});
              })
          : const Icon(CupertinoIcons.right_chevron),
    );
  }
}
