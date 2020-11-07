import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/DeveloperTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Credits extends StatefulWidget {
  Credits({Key key, this.title}) : super(key: key);

  final String title;

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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("developers_title")),
        centerTitle: true,
        automaticallyImplyLeading: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
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
                      new TextSpan(text: AppLocalizations.of(context).translate("developers_manager"), style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: "\n"),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Francesco Scala",
                          imageName: "images/developers/scala.png",
                        ),
                      ),
                      new TextSpan(text: "\n\n\n\n"),
                      new TextSpan(text: AppLocalizations.of(context).translate("developers_team"), style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: "\n"),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Francesco Scala",
                          imageName: "images/developers/scala.png",
                        ),
                      ),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Mattia Ricco",
                          imageName: "images/developers/ricco.jpg",
                        ),
                      ),
                      WidgetSpan(
                        child: DeveloperTile (
                          name: "Andrea Germanà",
                          imageName: "images/developers/germana.jpg",
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