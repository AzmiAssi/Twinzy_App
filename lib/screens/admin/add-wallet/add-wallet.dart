// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Wallet"),
      ),
      body: Column(
        children: [
          spaceWidget(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          alignLabelWithHint: true,
                          labelText: "Wallet Phone Number",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          spaceWidget(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          alignLabelWithHint: true,
                          labelText: "Wallet Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          spaceWidget(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: valueController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.money),
                          alignLabelWithHint: true,
                          labelText: "Wallet Value",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          spaceWidget(height: 50),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(5)),
                    child: MaterialButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('wallets')
                            .where("phoneNumber",
                                isEqualTo: phoneNumberController.text)
                            .get()
                            .then((value) async {
                          if (value.docs.isEmpty) {
                            if (phoneNumberController.text.isEmpty ||
                                valueController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: translate('pleaseEnterFullInformation'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: primary,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('wallets')
                                  .add({
                                "phoneNumber": phoneNumberController.text,
                                "password": passwordController.text,
                                "value": valueController.text,
                              });
                              Fluttertoast.showToast(
                                  msg: translate('yourWalletAdded'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: primary,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              deleteField();
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: translate('thisWalletNumberIsExisted'),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: primary,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                      },
                      child: const Text(
                        "Add Wallet",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void deleteField() {
    passwordController.clear();
    valueController.clear();
    phoneNumberController.clear();
  }
}
