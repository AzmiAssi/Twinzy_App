// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:twinzy/models/cart_product.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String local = "ar";
int bottomNavigationBarIndex = 1;

List<CartProduct>? cartProduct = [];
double totalAmount = 0;
double totalQuantity = 0;
TextEditingController deliverylocationController =
    TextEditingController(text: 'Amman');
Map<String, dynamic>? user = {};
var sharedCheck;
