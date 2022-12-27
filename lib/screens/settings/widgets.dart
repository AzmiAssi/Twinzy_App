import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';

Widget settingsCard({text, icon, pageName}) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      onTap: () async {
        if (text == translate("logout")) {
          user!.clear();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();

          Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => pageName),
              (Route<dynamic> route) => false);
          bottomNavigationBarIndex = 1;
        } else if (pageName != null) {
          pushPage(context: navigatorKey.currentContext!, pageName: pageName);
        }
      },
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        size: 30,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    ),
  );
}
