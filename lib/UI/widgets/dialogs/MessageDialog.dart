import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:flutter/material.dart';


class MessageDialog extends StatelessWidget {
  final String titleText;
  final String bodyText;


  const MessageDialog({Key key, this.titleText, this.bodyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedDialog(
      title: Text(
        titleText,
        style: LeoTitleStyle(),
        textAlign: TextAlign.center,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Text(
          bodyText,
          style: LeoParagraphStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


}