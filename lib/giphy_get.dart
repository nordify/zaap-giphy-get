library giphy_get;

// Imports
import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/gif.dart';
import 'package:giphy_get/src/client/models/languages.dart';
import 'package:giphy_get/src/client/models/rating.dart';
import 'package:giphy_get/src/providers/app_bar_provider.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:giphy_get/src/views/main_view.dart';
import 'package:provider/provider.dart';

// Giphy Client Export
export 'package:giphy_get/src/client/client.dart';
export 'package:giphy_get/src/client/models/collection.dart';
export 'package:giphy_get/src/client/models/gif.dart';
export 'package:giphy_get/src/client/models/image.dart';
export 'package:giphy_get/src/client/models/images.dart';
export 'package:giphy_get/src/client/models/languages.dart';
export 'package:giphy_get/src/client/models/rating.dart';
export 'package:giphy_get/src/client/models/type.dart';
export 'package:giphy_get/src/client/models/user.dart';
export 'package:giphy_get/src/widgets/giphy_get.widget.dart';
export 'package:giphy_get/src/widgets/giphy_gif.widget.dart';

typedef TabTopBuilder = Widget Function(BuildContext context);
typedef TabBottomBuilder = Widget Function(BuildContext context);
typedef SearchAppBarBuilder = Widget Function(
  BuildContext context,
  FocusNode focusNode,
  bool autofocus,
  TextEditingController textEditingController,
  void Function() onClearSearch,
);

class GiphyGet {
  // Show Bottom Sheet
  static Future<GiphyGif?> getGif({
    required BuildContext context,
    required String apiKey,
    String rating = GiphyRating.g,
    String lang = GiphyLanguage.english,
    String randomID = "",
    String searchText = "",
    String queryText = "",
    int debounceTimeInMilliseconds = 350,
    TabBottomBuilder? tabBottomBuilder,
    SearchAppBarBuilder? searchAppBarBuilder,
  }) {
    if (apiKey == "") {
      throw Exception("apiKey must be not null or not empty");
    }

    return showModalBottomSheet<GiphyGif>(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AppBarProvider(
              queryText = queryText,
              debounceTimeInMilliseconds,
            ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => SheetProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => TabProvider(
              apiKey: apiKey,
              randomID: randomID,
              searchText: searchText,
              rating: rating,
              lang: lang,
            ),
          )
        ],
        child: SafeArea(
          child: MainView(
            tabBottomBuilder: tabBottomBuilder,
            searchAppBarBuilder: searchAppBarBuilder,
          ),
        ),
      ),
    );
  }
}
