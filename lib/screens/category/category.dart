import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/category/widgets.dart';
import 'package:twinzy/screens/sub-category/sub-category.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/theme/colors.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("homePage")),
          actions: const [
            Padding(padding: EdgeInsets.all(15.0), child: Icon(Icons.home))
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(25)),
                width: double.infinity,
                child: const Text(
                  "Welcome to twinzy ! We are happy to have you,get ready to order and enjoy our amazing desserts",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            BuildProfile(
              title: translate("Cookies"),
              onTap: () => {
                pushPage(
                    context: context,
                    pageName: SubCategory(
                      sub: '0',
                    ))
              },
              image: 'assets/images/cookies.png',
            ),
            BuildProfile(
              title: translate("bakedCheesecake"),
              onTap: () => {
                pushPage(
                    context: context,
                    pageName: SubCategory(
                      sub: '1',
                    ))
              },
              image: 'assets/images/cheesecake.png',
            ),
          ],
        ));
  }
}
