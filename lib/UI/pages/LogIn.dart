import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Home.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:flutter/material.dart';


class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);


  @override
  _LogIn createState() => _LogIn();
}

class _LogIn extends GlobalState<LogIn> {
  final inputController = TextEditingController();

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            StadiumButton(
              icon: Icons.login,
              title: AppLocalizations.of(context).translate("log_in"),
              onPressed: () {
                ModelFacade.sharedInstance.loadInfoCurrentClub();
                Navigator.of(context).push(
                  PageRouteBuilder(
                      opaque: false,
                      transitionDuration: Duration(milliseconds: 700),
                      pageBuilder: (BuildContext context, _, __) => Home()
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }


}