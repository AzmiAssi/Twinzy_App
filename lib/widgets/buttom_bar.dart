import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/cart/cart.dart';
import 'package:twinzy/screens/category/category.dart';
import 'package:twinzy/screens/search/search.dart';
import 'package:twinzy/screens/settings/settings.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavigationBarIndex == 1
          ? const Category()
          : bottomNavigationBarIndex == 2
              ? const CartScreen()
              : bottomNavigationBarIndex == 3
                  ? const Search()
                  : const Settings(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: const Offset(
                5.0,
                5.0,
              ),
            )
          ],
        ),
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomBarIcon(
              icon: Icons.home,
              index: 1,
              text: translate("home"),
              ontap: () {
                setState(() {
                  bottomNavigationBarIndex = 1;
                });
              },
            ),
            bottomBarIcon(
                icon: Icons.shopping_cart,
                index: 2,
                text: translate("cart"),
                ontap: () {
                  setState(() {
                    bottomNavigationBarIndex = 2;
                  });
                },
                cart: true),
            bottomBarIcon(
              icon: Icons.search,
              index: 3,
              text: translate("search"),
              ontap: () {
                setState(() {
                  bottomNavigationBarIndex = 3;
                });
              },
            ),
            bottomBarIcon(
              icon: Icons.settings,
              index: 4,
              text: translate("settings"),
              ontap: () {
                setState(() {
                  bottomNavigationBarIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget bottomBarIcon({icon, index, text, ontap, bool cart = false}) {
  return InkWell(
    onTap: ontap,
    child: Column(
      children: [
        spaceWidget(
          height: 10,
        ),
        !cart
            ? Icon(
                icon,
                color:
                    bottomNavigationBarIndex == index ? primary : Colors.black,
              )
            : Center(
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Icon(
                      icon,
                      color: bottomNavigationBarIndex == index
                          ? primary
                          : Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                            color: bottomNavigationBarIndex == index
                                ? primary
                                : Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          cartProduct!.length.toString(),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        Text(
          translate(text),
          style: TextStyle(
              color:
                  bottomNavigationBarIndex == index ? primary : Colors.black),
        ),
      ],
    ),
  );
}
