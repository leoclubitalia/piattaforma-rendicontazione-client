import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:flutter/material.dart';


class ServiceDialog extends StatelessWidget {
  final Service service;


  const ServiceDialog({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        AppLocalizations.of(context).translate("welcome") + "!",
        style: LeoTitleStyle(),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Text(
            service.title,
            style: LeoParagraphStyle(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }


}