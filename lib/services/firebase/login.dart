import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinzy/screens/admin/admin-home.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/buttom_bar.dart';

Future login({phone, password, context}) async {
  await FirebaseFirestore.instance
      .collection('admins')
      .where('phone', isEqualTo: phone.toString().trim())
      .where('password', isEqualTo: password.toString().trim())
      .get()
      .then((admin) async {
    if (admin.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phone.toString().trim())
          .where('password', isEqualTo: password.toString().trim())
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(
              msg: translate('invalidEmailOrPassword'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: primary,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          user = value.docs[0].data();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", user!["email"]);
          prefs.setString("id", user!["id"]);
          prefs.setString("password", user!["password"]);
          prefs.setString("phone", user!["phone"]);
          prefs.setString("firstName", user!["firstName"]);
          prefs.setString("lastName", user!["lastName"]);
          prefs.setString("local", local);
          pushToRootPage(context: context, pageName: const HomePage());
        }
      });
    } else {
      pushToRootPage(context: context, pageName: const HomeAdmin());
    }
  });
}
