// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, no_logic_in_create_state, prefer_interpolation_to_compose_strings
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/models/cart_product.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/screens/auth/login.dart';
import 'package:twinzy/screens/details/widgets.dart';
import 'package:twinzy/services/calculate-total.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class ProductDetails extends StatefulWidget {
  Product? product;
  ProductDetails({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState(product);
}

class _ProductDetailsState extends State<ProductDetails> {
  Product? product;
  _ProductDetailsState(this.product);
  List<int> quantities = [];
  double? totalProduct = 0;
  void caculateTotalProduct() {
    totalProduct = 0;
    for (int i = 0; i < quantities.length; i++) {
      setState(() {
        totalProduct = (totalProduct! +
            (quantities[i].toDouble() * double.parse(product!.prices![i])));
      });
    }
  }

  @override
  void initState() {
    for (int i = 0; i < product!.sizes!.length; i++) {
      quantities.add(0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController(text: "-");
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('productDetails')),
      ),
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Column(children: [
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              CarouselSlider.builder(
                itemCount: product!.images!.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Row(
                  children: [
                    Expanded(
                        child: Image(
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/twinzy-project.appspot.com/o/productImage%2F${product!.images![itemIndex].toString()}?alt=media&token=2a1752da-9575-4ebd-a93e-6cdf54d8fa87"

                          // "${product!.images![itemIndex]}"
                          ),
                      fit: BoxFit.cover,
                    ))
                  ],
                ),
                options: CarouselOptions(
                  height: 350,
                  autoPlayCurve: Curves.ease,
                  aspectRatio: 0,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      product!.name.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBarIndicator(
                      direction: Axis.horizontal,
                      rating: double.parse(product!.rate.toString()),
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    user!["firstName"] == null
                        ? Container()
                        : TextButton(
                            child: Text(
                              translate("rate"),
                              style: const TextStyle(
                                  color: primary,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              rete(context: context, product: product);
                            }),
                    TextButton(
                        child: Text(
                          translate("reveiw"),
                          style: const TextStyle(
                              color: primary,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          reveiw(context: context, productName: product!.name);
                        })
                  ],
                ),
              ),

              // RatingBar.builder(
              //   initialRating: double.parse(product!.rate.toString()),
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   allowHalfRating: true,
              //   itemCount: 5,
              //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //   itemBuilder: (context, _) => Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   onRatingUpdate: (rating) {
              //     print(rating);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  product!.description.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 10,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Divider(),
              ),
              for (int i = 0; i < product!.sizes!.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product!.sizes![i],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  product!.prices![i] + " JD",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      spaceWidget(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            height: 38,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: primary, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (quantities[i] >= 1) {
                                        quantities[i] -= 1;
                                        caculateTotalProduct();
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    child: quantities[i] > 0
                                        ? const Icon(
                                            Icons.remove,
                                            color: Colors.grey,
                                          )
                                        : const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                                Text(
                                  quantities[i].toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantities[i] += 1;
                                      caculateTotalProduct();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),

              totalProduct != 0
                  ? const Padding(
                      padding: EdgeInsets.all(15),
                      child: Divider(),
                    )
                  : Container(),
              totalProduct != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                              controller: noteController,
                              minLines: 5,
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.note_add),
                                labelText: translate("addNote"),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                translate("totalPriceToTheProduct") + " : ",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                totalProduct.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primary),
                              )
                            ],
                          ),
                        ],
                      ))
                  : Container(),
            ]),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  if (user!["firstName"] == null) {
                    Fluttertoast.showToast(
                        msg: translate('shouldBeLoginOrCreateAcount'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: primary,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    int totalQuantities = 0;

                    for (int i = 0; i < quantities.length; i++) {
                      setState(() {
                        totalQuantities += quantities[i];
                      });
                    }
                    cartProduct!.add(CartProduct(
                        name: product!.name,
                        image: product!.images![0],
                        totalPrice: totalProduct,
                        description: product!.description,
                        id: product!.id,
                        totalQuantities: totalQuantities,
                        note: noteController.text));
                    setState(() {
                      for (int i = 0; i < quantities.length; i++) {
                        quantities[i] = 0;
                        totalProduct = 0;
                      }
                    });
                    setState(() {
                      calculateTotalAmount();
                    });
                    Fluttertoast.showToast(
                        msg: translate('productAddedToYourCart'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: primary,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  }
                });
              },
              child: Text(
                translate('addToCart'),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ]),
    );
  }
}
