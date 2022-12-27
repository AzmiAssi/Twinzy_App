import 'package:flutter/material.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/screens/admin/products/product-detals-admin.dart';
import 'package:twinzy/screens/details/product_details.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/theme/colors.dart';

Widget gridProduct(
    {List<Product>? productsList,
    required BuildContext context,
    required setState,
    admin}) {
  return GridView.count(
    crossAxisCount: 2,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 0.8,
    shrinkWrap: true,
    children: <Widget>[
      for (int i = 0; i < productsList!.length; i++)
        product(
            product: productsList[i],
            context: context,
            setState: setState,
            admin: admin),
    ],
  );
}

// -----------------------------------------------------------------------------

Widget product({required Product product, context, setState, admin}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: (() => {
            admin
                ? pushPage(
                    context: context,
                    pageName: ProductDetailsAdmin(
                      product: product,
                    ))
                : pushPage(
                    context: context,
                    pageName: ProductDetails(
                      product: product,
                    ))
          }),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/twinzy-project.appspot.com/o/productImage%2F${product.images![0]}?alt=media&token=2a1752da-9575-4ebd-a93e-6cdf54d8fa87"
                  // product.images![0],
                  ,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                product.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18, color: primary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
