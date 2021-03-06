import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/Credits.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/LogIn.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/MultipleTapButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Hub extends StatefulWidget {
  Hub({Key key}) : super(key: key);

  @override
  _HubState createState() => _HubState();
}

class _HubState extends GlobalState<Hub> {
  bool _isLoading = false;


  @override
  void refreshState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: AppLocalizations.of(context).translate("app_title"),
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
                      child: Semantics (
                        enabled: true,
                        label: Constants.APP_NAME,
                        readOnly: true,
                        hidden: false,
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
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        AppLocalizations.of(context).translate("go_to") + ":",
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                        style: LeoTitleStyle()
                      ),
                    ),
                    StadiumButton(
                      icon: Icons.book,
                      minWidth: 190,
                      title: AppLocalizations.of(context).translate("yearbook"),
                      onPressed: () async {
                        await launch("https://annuario.leoclub.it");
                      },
                    ),
                    StadiumButton(
                      icon: Icons.assessment_rounded,
                      minWidth: 190,
                      title: AppLocalizations.of(context).translate("rendicontation"),
                      onPressed: ()  {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            transitionDuration: Duration(milliseconds: 700),
                            pageBuilder: (BuildContext context, _, __) => LogIn(),
                          ),
                        );
                      },
                    ),
                    StadiumButton(
                      icon: Icons.medical_services_rounded,
                      minWidth: 190,
                      title: AppLocalizations.of(context).translate("request_ton"),
                      onPressed: () async {
                        await launch("https://richiesteton.leoclub.it");
                      },
                    ),
                    StadiumButton(
                      icon: Icons.bookmark_rounded,
                      minWidth: 190,
                      title: AppLocalizations.of(context).translate("wiki_leo"),
                      onPressed: () async {
                        await launch("https://wikileo.leoclub.it/");
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StadiumButton(
                          icon: Icons.arrow_downward_rounded,
                          minWidth: 140,
                          title: AppLocalizations.of(context).translate("downloads"),
                          onPressed: () async {
                            await launch("https://drive.google.com/drive/folders/1Vn2K1OMnXjA5ShE03nsfw4V7YxpElIUf");
                          },
                        ),
                        StadiumButton(
                          icon: Icons.star_rounded,
                          minWidth: 140,
                          title: AppLocalizations.of(context).translate("resources"),
                          onPressed: () async {
                            await launch("https://www.leoclub.it/risorse-soci/");
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                      child: Text(
                        AppLocalizations.of(context).translate("hub_description"),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Text(
                          "v" + Constants.APP_VERSION,
                          textAlign: TextAlign.center,
                          style: LeoParagraphStyle()
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
