import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/views/appbar/searchappbar.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_bottom.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_detail.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_top.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  MainView({
    Key? key,
    this.tabBottomBuilder,
    this.searchAppBarBuilder,
  }) : super(key: key);

  final TabBottomBuilder? tabBottomBuilder;
  final SearchAppBarBuilder? searchAppBarBuilder;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  // Scroll Controller
  late ScrollController _scrollController;

  // Sheet Provider
  late SheetProvider _sheetProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _sheetProvider = Provider.of<SheetProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _draggableScrollableSheet();
  }

  Widget _draggableScrollableSheet() => DraggableScrollableSheet(
      expand: _sheetProvider.isExpanded,
      snap: true,
      minChildSize: SheetProvider.minExtent,
      maxChildSize: SheetProvider.maxExtent,
      initialChildSize: _sheetProvider.initialExtent,
      builder: (ctx, scrollController) {
        // Set ScrollController

        this._scrollController = scrollController;
        return _bottomSheetBody();
      });

  Widget _bottomSheetBody() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GiphyTabTop(),
          SearchAppBar(
            scrollController: this._scrollController,
            searchAppBarBuilder: widget.searchAppBarBuilder,
          ),
          Expanded(
            child: GiphyTabDetail(
              type: GiphyType.gifs,
              scrollController: this._scrollController,
              key: null,
            ),
          ),
          widget.tabBottomBuilder?.call(context) ?? GiphyTabBottom(),
        ],
      );
}
