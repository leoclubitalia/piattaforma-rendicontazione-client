import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Home.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Activities extends StatefulWidget {
  Activities({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Activities createState() => _Activities();
}

class _Activities extends GlobalState<Activities> {
  final inputController = TextEditingController();

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar (
        title: AppLocalizations.of(context).translate("activities").capitalize,
        backable: true,
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