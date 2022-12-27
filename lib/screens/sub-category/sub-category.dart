// ignore_for_file: public_member_api_docs, sort_constructors_first, no_logic_in_create_state, must_be_immutable, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/screens/search/widget.dart';
import 'package:twinzy/theme/colors.dart';

class SubCategory extends StatefulWidget {
  String sub;
  SubCategory({
    Key? key,
    required this.sub,
  }) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState(sub);
}

class _SubCategoryState extends State<SubCategory> {
  String sub;
  _SubCategoryState(this.sub);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            sub == "0" ? translate("cookies") : translate("bakedCheesecake")),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where("categoryId", isEqualTo: sub)
              .snapshots(),
          builder: (context, snapshot) {
            List<Product> allProducts = [];
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: primary,
                  color: Colors.white,
                ),
              );
            }
            final products = snapshot.data!.docs;
            for (var product in products) {
              final productName = product.get('name');
              final productId = product.get('id');
              final productDescription = product.get('description');
              final productPrices = product.get('prices');
              final productImages = product.get('images');
              final productSizes = product.get('sizes');
              final productRate = product.get('rate');
              final oneProduct = Product(
                  description: productDescription,
                  id: productId,
                  images: productImages,
                  sizes: productSizes,
                  name: productName,
                  prices: productPrices,
                  rate: productRate);
              allProducts.add(oneProduct);
            }
            return gridProduct(
                productsList: allProducts,
                context: context,
                setState: setState,
                admin: false);
          }),
    );
  }
}
