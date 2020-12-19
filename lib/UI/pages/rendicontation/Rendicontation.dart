import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Credits.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Home.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Search.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/ExpandableButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/MultipleTapButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/LogInResult.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Rendicontation extends StatefulWidget {
  Rendicontation({Key key}) : super(key: key);

  @override
  _RendicontationState createState() => _RendicontationState();
}

class _RendicontationState extends GlobalState<Rendicontation> {
  bool _isLoading = false;


  @override
  void refreshState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: AppLocalizations.of(context).translate("rendicontation").capitalize,
      ),
      body: Stack(
        children: [
          _isLoading ?
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).buttonColor),
            ),
          ) :
          Padding(padding: EdgeInsets.all(0)),
          SingleChildScrollView(
            child: IgnorePointer(
              ignoring: _isLoading,
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
                        child: MultipleTapButton(
                          taps: 3,
                          onTaps: () async {
                            await launch("https://www.youtube.com/watch?v=UsyWQejtJ1o");
                          },
                          child: Image.asset(
                            "images/logo.png",
                            width: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.width - 100 : 400,
                          ),
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
                      onSubmit: (String email, String password) async {
                        setState(() {
                          _isLoading = true;
                        });
                        if ( email == "giucascasella" ) {
                          await launch("https://youtu.be/dUcUgJyR6IE");
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        if ( email == "rotary" ) {
                          await launch("https://www.youtube.com/embed/H07zYvkNYL8?rel=0&autoplay=1");
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        if ( email == null || email == "" || password == null || password == "" ) {
                          showDialog(
                            context: context,
                            builder: (context) => MessageDialog(
                              titleText: AppLocalizations.of(context).translate("oops").capitalize,
                              bodyText: AppLocalizations.of(context).translate("all_fields_required").capitalize,
                            ),
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        LogInResult result = await ModelFacade.sharedInstance.logIn(email, password);
                        setState(() {
                          _isLoading = false;
                        });
                        if ( result == LogInResult.logged ) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                opaque: false,
                                transitionDuration: Duration(milliseconds: 700),
                                pageBuilder: (BuildContext context, _, __) => Home()
                            ),
                          );
                        }
                        else if ( result == LogInResult.error_wrong_credentials ) {
                          showDialog(
                            context: context,
                            builder: (context) => MessageDialog(
                              titleText: AppLocalizations.of(context).translate("oops").capitalize,
                              bodyText: AppLocalizations.of(context).translate("user_or_password_wrong"),
                            ),
                          );
                        }
                        else if ( result == LogInResult.error_not_fully_setupped ) {
                          await launch(Constants.LINK_FIRST_SETUP_PASSWORD);
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (context) => MessageDialog(
                              titleText: AppLocalizations.of(context).translate("oops").capitalize,
                              bodyText: AppLocalizations.of(context).translate("unknown_error"),
                            ),
                          );
                        }
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
          ),
        ],
      ),
    );
  }


}
