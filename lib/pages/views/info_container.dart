import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:goswapinfo/common/globals.dart';

class InfoContainer extends StatelessWidget {
  final String value;
  final String title;
  final bool copy;
  final String tokenAddress;
  final String token1Address;
  InfoContainer({
    @required this.value,
    @required this.title,
    this.copy = true,
    this.tokenAddress,
    this.token1Address,
  });
  @override
  Widget build(BuildContext context) {
    IconButton copyValue = IconButton(
      icon: Icon(Icons.content_copy_rounded),
      tooltip: 'Copy',
      splashRadius: 20.0,
      onPressed: () {
        Clipboard.setData(
          ClipboardData(text: value),
        );
      },
    );
    IconButton openPage = IconButton(
      icon: Icon(Icons.open_in_new),
      tooltip: 'Open external link',
      splashRadius: 20.0,
      onPressed: () {
        launch(
            "${Globals.uiURL}/#/swap?inputCurrency=$tokenAddress&outputCurrency=$token1Address");
      },
    );

    String ellipsis = '...';
    return Container(
      constraints: BoxConstraints(maxWidth: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.start,
          ),
          Row(
            children: [
              Text(
                '${copy ? value.substring(0, 7) + ellipsis : value}',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              copy ? copyValue : openPage,
            ],
          ),
        ],
      ),
    );
  }
}
