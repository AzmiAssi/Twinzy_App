// ignore_for_file: depend_on_referenced_packages, file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:twinzy/screens/choose-country/choose-country.dart';
import 'package:twinzy/services/firebase/order.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';
import 'package:uuid/uuid.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isTrust = false;
  @override
  void initState() {
    super.initState();
  }

// DropdownButtonHideUnderline
  String paymentValue = translate('cash');
  var payment = [
    translate('zainCash'),
    translate('cash'),
  ];
  var id = const Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("checkOut")),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.circular(25)),
              width: double.infinity,
              child: Text(
                translate(
                    "If you order 10 products or more, delivery will take place after 4 days, and if less, after 2 days"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: primary, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: TextField(
                  controller: dateInput,
                  decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      icon: const Icon(Icons.calendar_month_outlined),
                      labelText: translate("dateOfDeliver")),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      keyboardType: TextInputType.text,
                      initialDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          totalQuantity > 10
                              ? DateTime.now().day + 4
                              : DateTime.now().day + 2,
                          DateTime.now().hour,
                          DateTime.now().minute,
                          DateTime.now().microsecond,
                          DateTime.now().millisecond),
                      firstDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          totalQuantity > 10
                              ? DateTime.now().day + 4
                              : DateTime.now().day + 2,
                          DateTime.now().hour,
                          DateTime.now().minute,
                          DateTime.now().microsecond,
                          DateTime.now().millisecond),
                      lastDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day + 30,
                          DateTime.now().hour,
                          DateTime.now().minute,
                          DateTime.now().microsecond,
                          DateTime.now().millisecond),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    }
                  },
                ))),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: TextField(
                  controller: deliverylocationController,
                  decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      icon: const Icon(Icons.room),
                      labelText: translate("deliverylocation")),
                  readOnly: true,
                  onTap: () {
                    pushPage(context: context, pageName: const ChooseCountry());
                  },
                ))),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              padding: const EdgeInsets.all(15),
              child: DropdownButton(
                hint: spaceWidget(
                    width: MediaQuery.of(context).size.width * 0.58),
                iconSize: 25,
                elevation: 3,
                value: paymentValue,
                isExpanded: true,
                icon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
                items: payment.map((payment) {
                  return DropdownMenuItem(
                    value: payment,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        payment,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    paymentValue = newValue.toString();
                  });
                },
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where("user", isEqualTo: user)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length > 5) {
                    isTrust = true;

                    return Container();
                  } else {
                    isTrust = false;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            translate(
                                "youMustPay25%OfTheAmountThroughTheWalle : ${totalAmount / 4}"),
                            style: const TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        spaceWidget(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: TextField(
                                      controller: phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.phone),
                                        alignLabelWithHint: true,
                                        labelText:
                                            translate("walletPhoneNumber"),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        spaceWidget(height: 30),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: TextField(
                                      controller: passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.password),
                                        alignLabelWithHint: true,
                                        labelText: translate("walletPassword"),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    );
                  }
                }
                return Container();
              }),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: MaterialButton(
                  onPressed: () async {
                    if (isTrust) {
                      List prod = [];
                      for (int i = 0; i < cartProduct!.length; i++) {
                        prod.add(cartProduct![i].toMap());
                      }

                      addOrder(order: {
                        "id": id.v1().toString(),
                        "totalAmount": totalAmount.toString(),
                        "totalQuantity": totalQuantity.toInt().toString(),
                        "user": user,
                        "deliveryLocation":
                            deliverylocationController.text.toString(),
                        "dateOfDeliver": dateInput.text.toString(),
                        "products": prod,
                        "time": DateTime.now(),
                        "paymentMethod": paymentValue
                      });
                      setState(() {
                        cartProduct = [];
                        deliverylocationController.clear();
                        dateInput.clear();
                        setState(() {});
                      });
                      Navigator.pop(context);
                    } else {
                      await FirebaseFirestore.instance
                          .collection('wallets')
                          .where("phoneNumber",
                              isEqualTo: phoneNumberController.text)
                          .where("password", isEqualTo: passwordController.text)
                          .get()
                          .then((value) async {
                        if (value.docs.isEmpty) {
                          Fluttertoast.showToast(
                              msg: translate('notFoundWalletOfThisNumber'),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: primary,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          if (double.parse(value.docs[0]["value"]) >=
                              (totalAmount / 4)) {
                            QuerySnapshot querySnap = await FirebaseFirestore
                                .instance
                                .collection('wallets')
                                .where("phoneNumber",
                                    isEqualTo: value.docs[0]["phoneNumber"])
                                .get();
                            QueryDocumentSnapshot doc = querySnap.docs[0];
                            DocumentReference docRef = doc.reference;
                            await docRef.update({
                              "value": (double.parse(value.docs[0]["value"]) -
                                      (totalAmount / 4))
                                  .toString()
                            });
                            // FirebaseFirestore.instance
                            //     .collection('wallets')
                            //     .doc()
                            //     .update({
                            //   "phoneNumber": value.docs[0]["phoneNumber"],
                            //   "password": value.docs[0]["password"],
                            // "value": (double.parse(value.docs[0]["value"]) -
                            //         (totalAmount / 4))
                            //     .toString()
                            // });
                            List prod = [];
                            for (int i = 0; i < cartProduct!.length; i++) {
                              prod.add(cartProduct![i].toMap());
                            }

                            addOrder(order: {
                              "id": id.v1().toString(),
                              "totalAmount": totalAmount.toString(),
                              "totalQuantity": totalQuantity.toInt().toString(),
                              "user": user,
                              "deliveryLocation":
                                  deliverylocationController.text.toString(),
                              "dateOfDeliver": dateInput.text.toString(),
                              "products": prod,
                              "time": DateTime.now(),
                              "paymentMethod": paymentValue
                            });
                            setState(() {
                              cartProduct = [];
                              deliverylocationController.clear();
                              dateInput.clear();
                              setState(() {});
                            });
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: translate('theBalanceIsNotEnough'),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: primary,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      });
                    }
                  },
                  child: Text(
                    translate('checkOut'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
