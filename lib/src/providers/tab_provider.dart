import 'package:flutter/widgets.dart';
import 'package:giphy_get/src/client/models/languages.dart';

class TabProvider with ChangeNotifier {
  String apiKey;
  Color? tabColor;
  Color? textSelectedColor;
  Color? textUnselectedColor;
  String? searchText;
  String lang = GiphyLanguage.english;
  String randomID = "";

  String? _tabType;
  String get tabType => _tabType ?? '';
  set tabType(String tabType) {
    _tabType = tabType;
    notifyListeners();
  }

  TabProvider({
    required this.apiKey,
    this.tabColor,
    this.textSelectedColor,
    this.textUnselectedColor,
    this.searchText,
    required this.randomID,
    required this.lang,
  });

  void setTabColor(Color tabColor) {
    tabColor = tabColor;
    notifyListeners();
  }
}
