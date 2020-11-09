import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Activities.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Credits.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Services.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/StringCapitalization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';


class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends GlobalState<Home> {
  Club club;

  @override
  void refreshState() {
    club = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB);
  }

  bool isCircularMoment() {
    return ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB) == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("home").capitalize),
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: isCircularMoment() ?
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).buttonColor),
          ),
        ) :
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  AppLocalizations.of(context).translate("hi").capitalize + "!",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              ColorFiltered(
                child: Image.asset(
                  "images/logo.png",
                  width: 200,
                ),
                colorFilter: ColorFilter.mode(
                    Theme.of(context).splashColor, BlendMode.modulate
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text(
                  club.name,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              StadiumButton(
                icon: UIConstants.ICON_SERVICE,
                title: AppLocalizations.of(context).translate("service"),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      transitionDuration: Duration(milliseconds: 700),
                      pageBuilder: (BuildContext context, _, __) => Services()
                    ),
                  );
                },
              ),
              StadiumButton(
                icon: UIConstants.ICON_ACTIVITY,
                title: AppLocalizations.of(context).translate("activity"),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      transitionDuration: Duration(milliseconds: 700),
                      pageBuilder: (BuildContext context, _, __) => Activities()
                    ),
                  );
                },
              ),




              Padding(
                padding: EdgeInsets.all(10),
              ),
              club == null ? Text("no club") : Column(
                children: [
                  Text("name: " + club.name + " email: " + club.email + " district: " + club.district.name),
                  Text("quantity services: " + club.quantityServices.toString()),
                  Text("quantity activities: " + club.quantityActivities.toString()),
                ],
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          child: LiquidCircularProgressIndicator(
                            value: (club.quantityServices.currentYear / 15),
                            valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                            backgroundColor: Colors.white,
                            borderColor: Theme.of(context).buttonColor,
                            borderWidth: 3.0,
                            direction: Axis.vertical,
                          ),
                        ),
                        Text(
                            "Services questo anno " + club.quantityServices.currentYear.toString()
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          child: LiquidCircularProgressIndicator(
                              value: (club.quantityActivities.currentYear / 15),
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                            backgroundColor: Colors.white,
                            borderColor: Theme.of(context).buttonColor,
                            borderWidth: 3.0,
                            direction: Axis.vertical,
                          ),
                        ),
                        Text(
                            "Attività questo anno " + club.quantityActivities.currentYear.toString()
                        ),
                      ],
                    ),
                  ),
                ],
              ),




              Padding (
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: FlatButton(
                  minWidth: 100000,
                  color: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false,
                          transitionDuration: Duration(milliseconds: 700),
                          pageBuilder: (BuildContext context, _, __) => Credits()
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).translate("this_app_was_developed_by"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}