import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Credits.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Home.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Search.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/LogIn.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/ExpandableButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:flutter/material.dart';


class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends GlobalState<Welcome> {

  @override
  void refreshState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: AppLocalizations.of(context).translate("app_title"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Text(
                  AppLocalizations.of(context).translate("welcome") + "!",
                  textAlign: TextAlign.center,
                  textScaleFactor: 3,
                  style: LeoBigTitleStyle()
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                child: Container(
                  height: 230,
                  child: Image.asset(
                    "images/logo.png",
                    width: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.width - 100 : 400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  AppLocalizations.of(context).translate("log_in_as"),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                  style: LeoTitleStyle()
                ),
              ),
              ExpandableLogInButton(
                textOuterButton: AppLocalizations.of(context).translate("club"),
                onSubmit: (String email, String password){
                  //TODO call login to server
                  // TODO fare chiamata asicntrona
                  // TODO apparire rotella e se non buon fine rimanere qui
                  ModelFacade.sharedInstance.loadInfoCurrentClub();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (BuildContext context, _, __) => Home()
                    ),
                  );
                },
              ),
              StadiumButton(
                icon: Icons.person,
                title: AppLocalizations.of(context).translate("guest"),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      transitionDuration: Duration(milliseconds: 700),
                      pageBuilder: (BuildContext context, _, __) => Search(true)
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Text(
                  AppLocalizations.of(context).translate("log_in_as_description"),
                  textAlign: TextAlign.center,
                  style: LeoParagraphStyle()
                ),
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(0, 100, 0, 20),
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
