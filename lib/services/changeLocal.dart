// ignore_for_file: file_names

import 'package:twinzy/shared/shared.dart';

void localChange({setState}) {
  setState(() {
    if (local == 'ar') {
      local = 'en';
    } else {
      local = 'ar';
    }
  });
}
