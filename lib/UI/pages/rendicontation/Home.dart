import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Activities.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Credits.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Search.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Services.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/MultipleTapButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/SubmittableInputField.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);


  @override
  _Home createState() => _Home();
}

class _Home extends GlobalState<Home> {
  Club _club;

  TextEditingController _inputFieldMembersController = TextEditingController();
  TextEditingController _inputFieldAspirantsController = TextEditingController();

  @override
  void refreshState() {
    _club = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB);
    if ( _club != null ) {
      _inputFieldMembersController.text = _club.currentMembers.toString();
      _inputFieldAspirantsController.text = _club.aspirantMembers.toString();
    }
  }

  bool isCircularMoment() {
    return ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB) == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar (
        title: AppLocalizations.of(context).translate("home").capitalize,
        backable: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              ModelFacade.sharedInstance.logOut();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.logout,
              size: 26.0,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => MessageDialog(
                    titleText: AppLocalizations.of(context).translate("info").capitalize,
                    bodyText: AppLocalizations.of(context).translate("info_home"),
                  ),
                );
              },
              child: Icon(
                Icons.info_outline,
                size: 26.0,
              ),
            ),
          ),
        ],
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
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  AppLocalizations.of(context).translate("hi").capitalize + "!",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 30),
                child: Container(
                  height: 230,
                  child: MultipleTapButton(
                    taps: 3,
                    onTaps: () async {
                      await launch("https://youtu.be/86i69k6H16E?t=45");
                    },
                    child: Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.width - 100 : 400,
                    ),
                  ),
                ),
              ),
              Text(
                _club.name,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate("district").capitalize + " " + _club.district.name,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              _club.foundationDate != null ?
              Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 25),
                child: Text(
                  AppLocalizations.of(context).translate("since").capitalize + " " + _club.foundationDate.year.toString(),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ) :
              Padding(padding: EdgeInsets.all(20)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StadiumButton(
                      icon: UIConstants.ICON_SERVICE,
                      title: AppLocalizations.of(context).translate("service").capitalize,
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
                      title: AppLocalizations.of(context).translate("activity").capitalize,
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("service").capitalize,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: LiquidCircularProgressIndicator(
                              value: (_club.quantityServices.currentYear / Constants.AVERAGE_SERVICES_PER_CLUB),
                              valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                              backgroundColor: Theme.of(context).primaryColor,
                              borderColor: Theme.of(context).buttonColor,
                              borderWidth: 3.0,
                              direction: Axis.vertical,
                            ),
                          ),
                          Text(
                              AppLocalizations.of(context).translate("this_year") + " " + _club.quantityServices.currentYear.toString()
                          ),
                          Text(
                              AppLocalizations.of(context).translate("since_the_foundation") + " " + (_club.quantityServices.currentYear + ( DateTime.now().year - _club.foundationDate.year) * Constants.AVERAGE_SERVICES_PER_CLUB).toString()
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("activity").capitalize,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: LiquidCircularProgressIndicator(
                              value: (_club.quantityActivities.currentYear / Constants.AVERAGE_ACTIVITIES_PER_CLUB),
                              valueColor: AlwaysStoppedAnimation(Colors.blue),
                              backgroundColor: Theme.of(context).primaryColor,
                              borderColor: Theme.of(context).buttonColor,
                              borderWidth: 3.0,
                              direction: Axis.vertical,
                            ),
                          ),
                          Text(
                              AppLocalizations.of(context).translate("this_year") + " " + _club.quantityActivities.currentYear.toString()
                          ),
                          Text(
                              AppLocalizations.of(context).translate("since_the_foundation") + " " + (_club.quantityActivities.currentYear + ( DateTime.now().year - _club.foundationDate.year) * Constants.AVERAGE_ACTIVITIES_PER_CLUB).toString()
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 125,
                          child: SubmittableInputField(
                            onSubmit: (String value) {
                              ModelFacade.sharedInstance.updateQuantityMembers(value);
                            },
                            keyboardType: TextInputType.number,
                            label: AppLocalizations.of(context).translate("members").capitalize,
                            value: _club.currentMembers.toString(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(25),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 125,
                          child: SubmittableInputField(
                            onSubmit: (String value) {
                              ModelFacade.sharedInstance.updateQuantityAspirants(value);
                            },
                            keyboardType: TextInputType.number,
                            label: AppLocalizations.of(context).translate("aspirants").capitalize,
                            value: _club.aspirantMembers.toString(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: StadiumButton(
                  icon: Icons.search_rounded,
                  title: AppLocalizations.of(context).translate("search").capitalize,
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (BuildContext context, _, __) => Search(false)
                      ),
                    );
                  }
                ),
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: FlatButton(
                  minWidth: 100000,
                  color: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () async {
                    await launch("https://youtu.be/unZFPiwRV9o");
                  },
                  child: Text(
                    AppLocalizations.of(context).translate("tutorial").capitalize,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ),
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(0, 25, 0, 20),
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