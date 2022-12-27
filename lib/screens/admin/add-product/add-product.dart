// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  dynamic _showSelectImageDialog() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  Future _iosBottomSheet() async => showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            // title: Text('Add Photo'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () => _upload(ImageSource.camera),
                child: const Text('Take Photo'),
              ),
              CupertinoActionSheetAction(
                onPressed: () => _upload(ImageSource.gallery),
                child: const Text('Choose Photo'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          );
        },
      );
  _androidDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => _upload(ImageSource.camera),
              child: const Text('Take Photo'),
            ),
            SimpleDialogOption(
              onPressed: () => _upload(ImageSource.gallery),
              child: const Text('Choose From Gallery'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _upload(ImageSource source) async {
    var picker = ImagePicker();
    picker
        .pickImage(
            source: source, maxHeight: 800, maxWidth: 800, imageQuality: 80)
        .then((value) {
      XFile? image = value;

      if (image != null) {
        setState(() {
          selectedFiles.add(File.fromUri(Uri.file(image.path)));
        });

        // uploadImage(File.fromUri(Uri.file(image.path)));
      }
    });
    setState(() {});
    Navigator.pop(context);
  }

  Future uploadImage() async {
    for (int i = 0; i < selectedFiles.length; i++) {
      String fileName = DateTime.now().toString();
      try {
        await FirebaseStorage.instance
            .ref('productImage/$fileName')
            .putFile(selectedFiles[i]);
        print("Successfully upload file ${selectedFiles[i].path}");
        uploadedFiles.add(fileName);
      } on FirebaseException catch (e) {
        print('error is ${e.message}');
      }
    }
    return true;
  }

  void deleteField() {
    setState(() {
      sizesController.clear();
      pricesController.clear();
      uploadedFiles.clear();
      selectedFiles.clear();
      productNameController.clear();
      productDescriptionController.clear();
      numberOfSizes = 1;
      sizesController.add(TextEditingController());
      pricesController.add(TextEditingController());
    });
  }

  var categoryid = "0";
  Map<String, String> categoryValue = {"name": "Cookies", "id": "0"};
  // {"name": "Cookies", "id": "0"};
  var category = [
    {"name": "Baked Cheese Cake", "id": "1"},
    {"name": "Cookies", "id": "0"}
  ];
  List<TextEditingController> sizesController = [TextEditingController()];
  List<TextEditingController> pricesController = [TextEditingController()];
  List<String> uploadedFiles = [];
  List<File> selectedFiles = [];
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  int numberOfSizes = 1;
  @override
  void initState() {
    categoryValue = category[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            "Category Of Product",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.all(15),
            child: DropdownButton(
              hint:
                  spaceWidget(width: MediaQuery.of(context).size.width * 0.58),
              iconSize: 25,
              elevation: 3,
              value: categoryValue,
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              items: category.map((categoryone) {
                return DropdownMenuItem(
                  value: categoryone,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      categoryone["name"].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  categoryValue = newValue as Map<String, String>;
                });
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Product Name",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: productNameController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.text_format),
              labelText: "Product Name",
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Product Description",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            maxLines: 7,
            controller: productDescriptionController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
              labelText: "Product Description",
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Product Images",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _showSelectImageDialog();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_a_photo,
                          size: 30,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          translate("uploadPhotos"),
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ))),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 120,
          child: selectedFiles.isNotEmpty
              ? ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (int i = 0; i < selectedFiles.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: SizedBox(
                            width: 130.0, child: Image.file(selectedFiles[i])),
                      ),
                  ],
                )
              : Container(
                  height: 5,
                ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Number Of Sizes",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              height: 50,
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
                        if (numberOfSizes > 1) {
                          numberOfSizes -= 1;
                          sizesController.removeLast();
                          pricesController.removeLast();
                          // caculateTotalProduct();
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: numberOfSizes > 1
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
                    numberOfSizes.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        numberOfSizes += 1;
                        sizesController.add(TextEditingController());
                        pricesController.add(TextEditingController());
                        // caculateTotalProduct();
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
            )
          ],
        ),
        for (int i = 1; i <= numberOfSizes; i++)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Size And Price $i",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: sizesController[i - 1],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.density_medium),
                    labelText: "Size $i",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: pricesController[i - 1],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.payments),
                    labelText: "Price $i",
                  ),
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(5)),
                  child: MaterialButton(
                    onPressed: () async {
                      bool isImpty = false;
                      Uuid? id = const Uuid();
                      List prices = [];
                      List sizes = [];
                      for (int i = 0; i < numberOfSizes; i++) {
                        if (sizesController[i].text.isEmpty ||
                            pricesController[i].text.isEmpty) {
                          isImpty = true;
                        }
                        prices.add(pricesController[i].text);
                        sizes.add(sizesController[i].text);
                      }
                      if (productDescriptionController.text.isEmpty ||
                          productNameController.text.isEmpty ||
                          selectedFiles.isEmpty ||
                          isImpty == true) {
                        Fluttertoast.showToast(
                            msg: translate('pleaseEnterFullInformation'),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: primary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        // "https://firebasestorage.googleapis.com/v0/b/touseelapp-4e80a.appspot.com/o/ImageOrder%2F${order["images"][i]}?alt=media&token=b06cf771-abbf-42af-8fff-e3cebdf3e568"
                        // https://firebasestorage.googleapis.com/v0/b/twinzy-project.appspot.com/o/productImages%2FDell.png?alt=media&token=2a1752da-9575-4ebd-a93e-6cdf54d8fa87
                        await uploadImage();
                        await FirebaseFirestore.instance
                            .collection('products')
                            .add({
                          "id": id.v1().toString(),
                          "categoryId": categoryValue["id"],
                          "description": productDescriptionController.text,
                          "name": productNameController.text,
                          "images": uploadedFiles,
                          "prices": prices,
                          "sizes": sizes,
                          "rate": "2.5"
                        });
                        Fluttertoast.showToast(
                            msg: translate('yourProductAdded'),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: primary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        deleteField();
                      }
                    },
                    child: const Text(
                      "Add Product",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
