// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartProduct {
  String? id;
  String? name;
  String? image;
  double? totalPrice;
  String? description;
  int? totalQuantities;
  String? note;
  CartProduct(
      {required this.name,
      required this.image,
      required this.totalPrice,
      required this.description,
      required this.id,
      required this.totalQuantities,
      this.note});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['images'],
      totalPrice: json['prices'],
      totalQuantities: json['quantities'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'totalPrice': totalPrice,
      'description': description,
      'totalQuantities': totalQuantities,
      'note': note,
    };
  }

  String toJson() => json.encode(toMap());
}
