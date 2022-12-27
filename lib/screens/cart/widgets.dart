// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, non_constant_identifier_names
// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/models/cart_product.dart';
import 'package:twinzy/shared/shared.dart';

Widget cartProductWidget(
    {required CartProduct productCart,
    totalPrice,
    totalQuantity,
    note,
    setState}) {
  return Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            height: 125,
            child: Row(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      child: Image(
                        height: 125,
                        width: 130,
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/twinzy-project.appspot.com/o/productImage%2F${productCart.image!}?alt=media&token=2a1752da-9575-4ebd-a93e-6cdf54d8fa87"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate("name"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        translate("totalQuantity"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        translate("totalPrice"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        translate("note"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ': ${productCart.name}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ': $totalQuantity',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ': $totalPrice',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ': $note',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FloatingActionButton(
            backgroundColor: Colors.red,
            mini: true,
            heroTag: productCart.id.toString(),
            child: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                cartProduct!.remove(productCart);
              });
            }),
      ),
    ],
  );
}
