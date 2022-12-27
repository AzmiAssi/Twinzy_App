import 'package:flutter/material.dart';

void pushPage({context, pageName}) {
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => pageName,
    ),
  );
}

void pushToRootPage({context, pageName}) {
  Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => pageName,
      ),
      (Route<dynamic> route) => false);
}
