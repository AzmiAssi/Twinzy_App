import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/models/product.dart';
import 'package:twinzy/screens/search/widget.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

TextEditingController searchController = TextEditingController();

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("search")),
        actions: const [
          Padding(padding: EdgeInsets.all(15.0), child: Icon(Icons.search))
        ],
      ),
      body: ListView(
        children: [
          spaceWidget(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                labelText: translate("searchProductName"),
              ),
            ),
          ),
          spaceWidget(height: 20),
          searchController.text.isEmpty
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
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
                  })
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
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
                      if (productName
                          .toString()
                          .contains(searchController.text.trim())) {
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
                    }
                    if (allProducts.isNotEmpty) {
                      return gridProduct(
                          productsList: allProducts,
                          context: context,
                          setState: setState,
                          admin: false);
                    }
                    return Center(
                      child: Column(
                        children: [
                          const Image(
                              image: AssetImage("assets/images/noResult.png")),
                          Text(
                            translate("notFoundProductsAtThisName"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  })
        ],
      ),
    );
  }
}
