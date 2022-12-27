// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

Future deleteProduct({id}) async {
  await FirebaseFirestore.instance
      .collection("products")
      .where("id", isEqualTo: id)
      .get()
      .then((value) => value.docs[0].reference.delete());
}

Future deleteUser({id}) async {
  await FirebaseFirestore.instance
      .collection("users")
      .where("id", isEqualTo: id)
      .get()
      .then((value) => value.docs[0].reference.delete());
}

Future deleteOrder({id}) async {
  await FirebaseFirestore.instance
      .collection("orders")
      .where("id", isEqualTo: id)
      .get()
      .then((value) => value.docs[0].reference.delete());
}
