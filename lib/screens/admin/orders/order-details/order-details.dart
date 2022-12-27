// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, no_logic_in_create_state, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/models/order.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';
import 'widget.dart';

class OrederDetails extends StatefulWidget {
  UserOrder details;
  OrederDetails({Key? key, required this.details}) : super(key: key);
  @override
  State<OrederDetails> createState() => _OrederDetailsState(details);
}

class _OrederDetailsState extends State<OrederDetails> {
  UserOrder details;
  _OrederDetailsState(this.details);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order id : ' +
                        details.id!.substring(
                            details.id!.length - 12, details.id!.length),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    details.time.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          "User Name : ",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        spaceWidget(width: 10),
                        Text(
                          details.user["firstName"],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Text(translate('delivered'),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        details.products.length.toString() + ' ' + "Items",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        for (int i = 0; i < details.products.length; i++)
          orderProduct(details.products[i]),
        spaceWidget(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Delivery Location",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Date Of Deliver",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Total Quantity",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Payment Method",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Total Amount",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              spaceWidget(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        " : " + details.deliveryLocation.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        " : " + details.dateOfDeliver.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        " : " + details.totalQuantity.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        " : " + details.paymentMethod.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        " : " + details.totalAmount.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(navigatorKey.currentState!.context)
                        .size
                        .width /
                    2.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    translate('share'),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(navigatorKey.currentState!.context)
                        .size
                        .width /
                    2.6,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    translate('reorder'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
