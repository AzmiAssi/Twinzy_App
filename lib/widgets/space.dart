import 'package:flutter/material.dart';

Widget spaceWidget({height = 0, width = 0}) {
  return SizedBox(
    height: double.parse(height.toString()),
    width: double.parse(width.toString()),
  );
}
