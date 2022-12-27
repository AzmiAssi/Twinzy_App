// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class UserOrder {
  String? dateOfDeliver;
  String? deliveryLocation;
  String? paymentMethod;
  String? id;
  String? time;
  String? totalAmount;
  String? totalQuantity;
  Map user;
  List<dynamic> products;
  UserOrder({
    this.dateOfDeliver,
    this.deliveryLocation,
    this.paymentMethod,
    this.id,
    this.time,
    this.totalAmount,
    this.totalQuantity,
    required this.user,
    required this.products,
  });

  UserOrder copyWith({
    String? dateOfDeliver,
    String? deliveryLocation,
    String? paymentMethod,
    String? id,
    String? time,
    String? totalAmount,
    String? totalQuantity,
    Map<String, String>? user,
    List<Map<String, String>?>? products,
  }) {
    return UserOrder(
      dateOfDeliver: dateOfDeliver ?? this.dateOfDeliver,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      id: id ?? this.id,
      time: time ?? this.time,
      totalAmount: totalAmount ?? this.totalAmount,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      user: user ?? this.user,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateOfDeliver': dateOfDeliver,
      'deliveryLocation': deliveryLocation,
      'paymentMethod': paymentMethod,
      'id': id,
      'time': time,
      'totalAmount': totalAmount,
      'totalQuantity': totalQuantity,
      'user': user,
      'products': products,
    };
  }

  @override
  bool operator ==(covariant UserOrder other) {
    if (identical(this, other)) return true;

    return other.dateOfDeliver == dateOfDeliver &&
        other.deliveryLocation == deliveryLocation &&
        other.paymentMethod == paymentMethod &&
        other.id == id &&
        other.time == time &&
        other.totalAmount == totalAmount &&
        other.totalQuantity == totalQuantity &&
        mapEquals(other.user, user) &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return dateOfDeliver.hashCode ^
        deliveryLocation.hashCode ^
        paymentMethod.hashCode ^
        id.hashCode ^
        time.hashCode ^
        totalAmount.hashCode ^
        totalQuantity.hashCode ^
        user.hashCode ^
        products.hashCode;
  }
}
