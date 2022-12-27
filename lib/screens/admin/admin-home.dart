// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/admin/add-product/add-product.dart';
import 'package:twinzy/screens/admin/add-wallet/add-wallet.dart';
import 'package:twinzy/screens/admin/orders/orders.dart';
import 'package:twinzy/screens/admin/products/products-admin.dart';
import 'package:twinzy/screens/admin/users/users.dart';
import 'package:twinzy/screens/admin/widgets.dart';
import 'package:twinzy/screens/auth/login.dart';
import 'package:twinzy/widgets/space.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admins Page"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Center(
          //   child: SizedBox(
          //     width: 250,
          //     height: 250,
          //     child: Image.asset('assets/images/splash.png'),
          //   ),
          // ),
          spaceWidget(height: 10),
          adminActionCard(
            icon: Icons.add_circle,
            text: translate("Add Product"),
            pageName: const AddProduct(),
          ),
          adminActionCard(
            icon: Icons.now_widgets_sharp,
            text: translate("products"),
            pageName: const ProductsAdmin(),
          ),
          adminActionCard(
            icon: Icons.shopping_bag,
            text: translate("orders"),
            pageName: const Orders(),
          ),
          adminActionCard(
            icon: Icons.person,
            text: translate("users"),
            pageName: const UsersAdmin(),
          ),
          adminActionCard(
            icon: Icons.wallet,
            text: translate("Add Wallet"),
            pageName: const AddWallet(),
          ),
          adminActionCard(
            icon: Icons.logout,
            text: translate("logout"),
            pageName: const LoginScreen(),
          ),
        ],
      ),
    );
  }
}
