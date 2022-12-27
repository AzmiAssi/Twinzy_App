// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/screens/search/widget.dart';
import 'package:twinzy/theme/colors.dart';

class ProductsAdmin extends StatefulWidget {
  const ProductsAdmin({Key? key}) : super(key: key);

  @override
  State<ProductsAdmin> createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
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
                admin: true);
          }),
    );
  }
}
