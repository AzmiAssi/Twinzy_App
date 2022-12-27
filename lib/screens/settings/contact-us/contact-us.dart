// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/settings/contact-us/widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('contactUs')),
      ),
      body: ListView(children: [
        contactCard(
            text: translate('whatsapp'),
            icon: Icons.whatsapp,
            text2: "0790000000"),
        contactCard(
            text: translate('facebook'),
            icon: Icons.facebook_outlined,
            text2: "Twinzy"),
        contactCard(
            text: translate('email'),
            icon: Icons.email,
            text2: "Twinzy2022@gmail.com"),
        contactCard(
            text: translate('instagram'),
            icon: FontAwesomeIcons.instagram,
            text2: "twinzy")
      ]),
    );
  }
}
