import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/buttom_bar.dart';
import 'package:uuid/uuid.dart';

void signUp({required Map user, context}) async {
  Uuid id = const Uuid();
  await FirebaseFirestore.instance
      .collection('users')
      .where('phone', isEqualTo: user["phone"].toString().trim())
      .get()
      .then((users) async {
    if (users.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('users').add({
        "firstName": user["firstName"],
        "lastName": user["lastName"],
        "phone": user["phone"],
        "email": user["email"],
        "password": user["password"],
        "id": id.v1().padRight(10).toString()
      });
      user = user;
      Fluttertoast.showToast(
          msg: translate('yourInformationSended'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: primary,
          textColor: Colors.white,
          fontSize: 16.0);
      pushToRootPage(context: context, pageName: const HomePage());
    } else {
      Fluttertoast.showToast(
          msg: translate('thisPhoneAlreadyExisted'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: primary,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  });
}
