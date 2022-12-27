import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/screens/cart/widgets.dart';
import 'package:twinzy/screens/check-out/check-out.dart';
import 'package:twinzy/services/calculate-total.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    setState(() {
      calculateTotalAmount();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text(translate("cart")),
        actions: const [
          Padding(
              padding: EdgeInsets.all(15.0), child: Icon(Icons.shopping_cart))
        ],
      ),
      body: cartProduct!.isEmpty
          ? SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/images/emptyCart.png'),
                        ),
                      ),
                      spaceWidget(height: 30),
                      Text(
                        translate("dontHaveAnyProductInCart"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24,
                            color: primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: double.infinity,
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        translate("ProductsInOrder :"),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 24,
                            color: primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (int i = 0; i < cartProduct!.length; i++)
                      cartProductWidget(
                          productCart: cartProduct![i],
                          totalPrice: cartProduct![i].totalPrice,
                          totalQuantity: cartProduct![i].totalQuantities,
                          note: cartProduct![i].note,
                          setState: setState),
                    Container(
                      height: 150,
                    )
                  ]),
                ),
                Container(
                  color: Colors.white,
                  height: 150,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              translate("TotalAmount :"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              " $totalAmount",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: primary),
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: const BoxDecoration(
                              color: primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                pushPage(
                                    context: context,
                                    pageName: const CheckOut());
                              });
                            },
                            child: Text(
                              translate('Apply'),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
