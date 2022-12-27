import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/auth/login.dart';
import 'package:twinzy/screens/settings/contact-us/contact-us.dart';
import 'package:twinzy/screens/settings/language/language.dart';
import 'package:twinzy/screens/settings/orders/orders.dart';
import 'package:twinzy/screens/settings/policy/policy.dart';
import 'package:twinzy/screens/settings/widgets.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/widgets/space.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("settings")),
        actions: const [
          Padding(padding: EdgeInsets.all(15.0), child: Icon(Icons.settings))
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Image.asset('assets/images/settingsLogo.png'),
            ),
          ),
          spaceWidget(height: 10),
          user!["firstName"] == null
              ? Container()
              : settingsCard(
                  icon: Icons.shopping_bag,
                  text: translate("myOrders"),
                  pageName: const OrdersUser(),
                ),
          settingsCard(
            icon: Icons.now_widgets_sharp,
            text: translate("policy"),
            pageName: const Policy(),
          ),
          settingsCard(
            icon: Icons.call,
            text: translate("contactUs"),
            pageName: const ContactUs(),
          ),
          settingsCard(
            icon: Icons.language,
            text: translate("language"),
            pageName: const LanguagePage(),
          ),
          user!["firstName"] == null
              ? Container()
              : settingsCard(
                  icon: Icons.logout,
                  text: translate("logout"),
                  pageName: const LoginScreen(),
                ),
        ],
      ),
    );
  }
}
