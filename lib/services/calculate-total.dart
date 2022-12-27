// ignore_for_file: file_names

import 'package:twinzy/shared/shared.dart';

void calculateTotalAmount() {
  totalAmount = 0;
  totalQuantity = 0;
  for (int i = 0; i < cartProduct!.length; i++) {
    totalAmount += cartProduct![i].totalPrice!;
    totalQuantity += cartProduct![i].totalQuantities!;
  }
}
