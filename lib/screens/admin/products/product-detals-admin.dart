// ignore_for_file: must_be_immutable, no_logic_in_create_state, file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/services/firebase/delete-admin.dart';
import 'package:twinzy/theme/colors.dart';

class ProductDetailsAdmin extends StatefulWidget {
  Product? product;
  ProductDetailsAdmin({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetailsAdmin> createState() =>
      _ProductDetailsAdminState(product);
}

class _ProductDetailsAdminState extends State<ProductDetailsAdmin> {
  Product? product;
  _ProductDetailsAdminState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    ],
                  ),
                ),
            ]),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: MaterialButton(
              onPressed: () async {
                setState(() {
                  deleteProduct(id: product!.id);
                });

                Fluttertoast.showToast(
                    msg: translate('productDeleted'),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: primary,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(
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
