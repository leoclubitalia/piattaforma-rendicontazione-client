import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/DeveloperTile.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';


class Credits extends StatefulWidget {
  Credits({Key key}) : super(key: key);


  @override
  _Credits createState() => _Credits();
}

class _Credits extends GlobalState<Credits> {

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar (
        title: AppLocalizations.of(context).translate("developers_title").capitalize,
        backable: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: new RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).splashColor,
                      fontWeight: FontWeight.w200
                    ),
                    children: [
                      new TextSpan(text: "\n\n"),
                      new TextSpan(text: AppLocalizations.of(context).translate("developers_manager") + ":", style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: "\n"),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Francesco Scala",
                          imageName: "images/developers/scala.png",
                          email: "francesco8ball@gmail.com",
                          instagram: "https://www.instagram.com/frank__ladder/",
                          facebook: "https://www.facebook.com/francesco.scala.35",
                        ),
                      ),
                      new TextSpan(text: "\n\n\n\n"),
                      new TextSpan(text: AppLocalizations.of(context).translate("developers_team") + ":", style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: "\n"),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Francesco Scala",
                          imageName: "images/developers/scala.png",
                          email: "francesco8ball@gmail.com",
                          instagram: "https://www.instagram.com/frank__ladder/",
                          facebook: "https://www.facebook.com/francesco.scala.35",
                        ),
                      ),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Mattia Ricco",
                          imageName: "images/developers/ricco.png",
                          email: "mattia.ricco.mr@gmail.com",
                          instagram: "https://www.instagram.com/grissinodeludente/?hl=it",
                          facebook: "https://www.facebook.com/mattia.ricco.3",
                        ),
                      ),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Andrea Germanà",
                          imageName: "images/developers/germana.png",
                          email: "andrea@germana.me",
                          instagram: "https://www.instagram.com/gemandra/",
                          facebook: "https://www.facebook.com/andgermana",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


}