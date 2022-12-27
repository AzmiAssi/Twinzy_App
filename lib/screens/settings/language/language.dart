import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('selectLanguage')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Image.asset('assets/images/language.png'),
            ),
          ),
          const Text(
            'Select Language',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          spaceWidget(height: 5),
          const Text(
            'اختر اللغة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          spaceWidget(height: 40),
          InkWell(
            onTap: () {
              setState(() {
                local = "ar";
                changeLocale(context, "ar");
              });
            },
            child: Container(
              width:
                  MediaQuery.of(navigatorKey.currentState!.context).size.width /
                      2,
              decoration: BoxDecoration(
                border: Border.all(color: primary),
                color: local == 'ar' ? primary : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "العربية",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: local == 'ar' ? Colors.white : primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    local == 'ar'
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 25,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          spaceWidget(height: 10),
          InkWell(
            onTap: () {
              setState(() {
                local = "en";
                changeLocale(context, local);
              });
            },
            child: Container(
              width:
                  MediaQuery.of(navigatorKey.currentState!.context).size.width /
                      2,
              decoration: BoxDecoration(
                border: Border.all(color: primary),
                color: local == 'en' ? primary : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "English",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: local == 'en' ? Colors.white : primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    local == 'en'
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 25,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
