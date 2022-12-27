// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';

Future rete({context, required Product? product}) {
  double rateChoose = 0.0;
  TextEditingController noteController = TextEditingController();
  return showDialog(
      barrierColor: primary.withOpacity(0.9),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 555,
                    width: 250,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            translate("youCanRateTheProductHere"),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/twinzy-project.appspot.com/o/productImage%2F${product!.images![0].toString()}?alt=media&token=2a1752da-9575-4ebd-a93e-6cdf54d8fa87"),
                                    radius: 40,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${translate("theRate")}  ${product.rate}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.star_rate,
                                          color: Colors.amber[700],
                                          size: 25,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating:
                                double.parse(product.rate.toString()),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              rateChoose = rating;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            height: 120,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: noteController,
                                style: const TextStyle(fontSize: 16),
                                maxLines: 4,
                                minLines: 3,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: translate("leaveANoteHere")),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: primary,
                                border: Border.all(color: Colors.blue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            height: 60,
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('rates')
                                    .add({
                                  "userName": user!["firstName"],
                                  "productName": product.name,
                                  "rate": rateChoose.toString(),
                                  "note": noteController.text
                                });

                                Fluttertoast.showToast(
                                    msg: translate('thankYouForRating'),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: primary,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                noteController.text = "";
                                Navigator.pop(context);
                              },
                              child: Text(
                                translate("rate"),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: primary,
                                border: Border.all(color: Colors.blue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            height: 60,
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                translate("back"),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      });
}

Future reveiw({context, productName}) {
  double rateChoose = 0.0;
  TextEditingController noteController = TextEditingController();
  return showDialog(
      barrierColor: primary.withOpacity(0.9),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Colors.white,
            content: SizedBox(
              // height: 555,
              width: 250,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('rates')
                              .where("productName", isEqualTo: productName)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: primary,
                                  color: Colors.white,
                                ),
                              );
                            }
                            final rates = snapshot.data!.docs;

                            return gridRates(
                                context: context, ratesList: rates);
                          }),
                    ],
                  ),
                ),
              ),
            ));
      });
}

Widget gridRates({ratesList, required BuildContext context}) {
  return GridView.count(
    crossAxisCount: 1,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.4,
    shrinkWrap: true,
    children: <Widget>[
      for (int i = 0; i < ratesList!.length; i++)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${ratesList[i]["userName"]}",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            RatingBarIndicator(
              direction: Axis.horizontal,
              rating: double.parse(ratesList[i]["rate"]),
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            Text(
              ratesList[i]["note"].toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: primary, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        )
    ],
  );
}
