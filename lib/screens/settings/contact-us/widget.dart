import 'package:flutter/material.dart';

Widget contactCard({text, icon, text2}) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: ListTile(
      subtitle: Text(text),
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      title: Text(
        text2,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        size: 30,
      ),
    ),
  );
}
