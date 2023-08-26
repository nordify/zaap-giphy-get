import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';

class GiphyGifWidget extends StatefulWidget {
  final GiphyGif gif;
  final GiphyGetWrapper giphyGetWrapper;
  final void Function(GiphyGif, GiphyGetWrapper)? onLongPress;
  const GiphyGifWidget({
    Key? key,
    required this.gif,
    required this.giphyGetWrapper,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<GiphyGifWidget> createState() => _GiphyGifWidgetState();
}

class _GiphyGifWidgetState extends State<GiphyGifWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onLongPress: () {
              widget.onLongPress?.call(widget.gif, widget.giphyGetWrapper);
            },
            child: ExtendedImage.network(
              
              widget.gif.images!.fixedWidth.url,
            ),
          ),
        ],
      ),
    );
  }
}
