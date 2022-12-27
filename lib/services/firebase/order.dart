import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/theme/colors.dart';

void addOrder({required Map order}) async {
  await FirebaseFirestore.instance.collection('orders').add({
    "id": order["id"],
    "totalAmount": order["totalAmount"],
    "totalQuantity": order["totalQuantity"],
    "user": order["user"],
    "deliveryLocation": order["deliveryLocation"],
    "dateOfDeliver": order["dateOfDeliver"],
    "products": order["products"],
    "time": order["time"].toString(),
    "paymentMethod": order["paymentMethod"]
  });
  Fluttertoast.showToast(
      msg: translate('yourOrderSended'),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: primary,
      textColor: Colors.white,
      fontSize: 16.0);
}
