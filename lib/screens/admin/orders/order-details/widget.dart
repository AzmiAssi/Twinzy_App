// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

Widget orderProduct(orderdata) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    child: Card(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35))),
        height: 115,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: Image(
                    fit: BoxFit.fill,
                    height: 115,
                    width: 140,
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/twinzy-project.appspot.com/o/productImage%2F${orderdata["image"].toString()}?alt=media&token=2a1752da-9575-4ebd-a93e-6cdf54d8fa87"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderdata["name"].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: primary),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Note",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                spaceWidget(width: 10),
                                Text(" : " + orderdata["note"].toString(),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Quantity",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                spaceWidget(width: 10),
                                Text(
                                    " : " +
                                        orderdata["totalQuantities"].toString(),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(orderdata["totalPrice"].toString() + "\$",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget orderDetails({title, text, bool isBold = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          translate(title) + " : ",
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Container(
          width: MediaQuery.of(navigatorKey.currentState!.context).size.width /
              1.7,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.w900 : FontWeight.w300),
          ),
        ),
      ],
    ),
  );
}
