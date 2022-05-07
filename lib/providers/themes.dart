import 'package:flutter/foundation.dart';

class RADTheme with ChangeNotifier {
  bool isDark = false;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
