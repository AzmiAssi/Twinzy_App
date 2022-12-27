import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/settings/policy/widget.dart';

class Policy extends StatefulWidget {
  const Policy({Key? key}) : super(key: key);
  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('privacyPolicy')),
      ),
      body: ListView(children: [
        policyCard(
            text: 'Terms of Service',
            policyText:
                'A standard Terms of Service document is included with every generated policy to make it easy to get started with your website policies.',
            context: context),
        policyCard(
            text: 'Cookie Policy',
            policyText:
                'Level up your GDPR compliance — outline in plain English to your audience how your website uses cookies and what they are for.',
            context: context),
        policyCard(
            text: 'Acceptable Use Policy',
            policyText:
                'For comprehensive packs, the included Acceptable Use Policy is an optional document determining how your website may be used.',
            context: context),
      ]),
    );
  }
}
