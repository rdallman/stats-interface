import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoContainer extends StatelessWidget {
  final String value;
  final String title;
  final bool copy;
  InfoContainer({
    this.value,
    this.copy = true,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
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
              IconButton(
                icon: Icon(Icons.content_copy_rounded),
                tooltip: 'Copy',
                splashRadius: 20.0,
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: value),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
