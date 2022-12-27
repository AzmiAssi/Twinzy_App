// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/models/order.dart';
import 'package:twinzy/screens/settings/orders/widget.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';

class OrdersUser extends StatefulWidget {
  const OrdersUser({Key? key}) : super(key: key);
  @override
  State<OrdersUser> createState() => _OrdersUserState();
}

class _OrdersUserState extends State<OrdersUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('orders')),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      translate('orders'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ]),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where("user")
                  .snapshots(),
              builder: (context, snapshot) {
                List<UserOrder> allOrders = [];
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: primary,
                      color: Colors.white,
                    ),
                  );
                }
                final orders = snapshot.data!.docs;
                for (var order in orders) {
                  final dateOfDeliver = order.get('dateOfDeliver');
                  final deliveryLocation = order.get('deliveryLocation');
                  final paymentMethod = order.get('paymentMethod');
                  final id = order.get('id');
                  String time = order.get('time');
                  final totalAmount = order.get('totalAmount');
                  final totalQuantity = order.get('totalQuantity');
                  final userInOrder = order.get('user');
                  List<dynamic> products =
                      order.get('products') as List<dynamic>;
                  final oneOrder = UserOrder(
                    id: id,
                    dateOfDeliver: dateOfDeliver,
                    deliveryLocation: deliveryLocation,
                    paymentMethod: paymentMethod,
                    products: products,
                    time: time.toString(),
                    totalAmount: totalAmount.toString(),
                    totalQuantity: totalQuantity.toString(),
                    user: userInOrder,
                  );
                  if (userInOrder["id"] == user!["id"]) {
                    allOrders.add(oneOrder);
                  }
                }
                return gridOrdersUser(
                    orders: allOrders, context: context, setState: setState);
              }),
        ],
      ),
    );
  }
}
