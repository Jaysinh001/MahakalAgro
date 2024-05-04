import "package:flutter/foundation.dart";

class LanguageSelectorProvider with ChangeNotifier {
  var _isEnglishSelected = true;

  void setLanguage(value) {
    _isEnglishSelected = value;
    notifyListeners();
  }

  bool get isEnglishSelected => _isEnglishSelected;
}
