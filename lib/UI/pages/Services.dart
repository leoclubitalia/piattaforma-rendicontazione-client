import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Home.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Services extends StatefulWidget {
  Services({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Services createState() => _Services();
}

class _Services extends GlobalState<Services> {
  final inputController = TextEditingController();

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(AppLocalizations.of(context).translate("home").capitalize),
        centerTitle: true,
        automaticallyImplyLeading: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            InputField(
              labelText: AppLocalizations.of(context).translate("email"),
              controller: inputController,
            ),
            InputField(
              labelText: AppLocalizations.of(context).translate("password"),
              controller: inputController,
            ),
          ],
        ),
      ),
    );
  }


}