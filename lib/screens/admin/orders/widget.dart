// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/models/order.dart';
import 'package:twinzy/screens/admin/orders/order-details/order-details.dart';
import 'package:twinzy/services/firebase/delete-admin.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

Widget gridOrders({
  List<UserOrder>? orders,
  required BuildContext context,
  required setState,
}) {
  return GridView.count(
    crossAxisCount: 1,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 0.92,
    shrinkWrap: true,
    children: <Widget>[
      for (int i = 0; i < orders!.length; i++) ordersWidget(orders[i], context)
    ],
  );
}

Widget ordersWidget(UserOrder ordersdata, context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'User Name : ' + ordersdata.user["firstName"].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  ordersdata.dateOfDeliver.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Order id : ' + ordersdata.id.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                          " : " + ordersdata.deliveryLocation.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          " : " + ordersdata.dateOfDeliver.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          " : " + ordersdata.totalQuantity.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          " : " + ordersdata.paymentMethod.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          " : " + ordersdata.totalAmount.toString(),
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(navigatorKey.currentState!.context)
                          .size
                          .width *
                      0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: MaterialButton(
                    onPressed: () {
                      pushPage(
                          context: context,
                          pageName: OrederDetails(
                            details: ordersdata,
                          ));
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(navigatorKey.currentState!.context)
                          .size
                          .width *
                      0.3,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.red),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: MaterialButton(
                    onPressed: () {
                      deleteOrder(id: ordersdata.id);

                      Fluttertoast.showToast(
                          msg: translate('orderDeleted'),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: primary,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      // Navigator.pop(context);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
