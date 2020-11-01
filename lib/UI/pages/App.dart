import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Credits.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Search.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/LogIn.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('it', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: "",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        backgroundColor: Colors.amber,
        buttonColor: Colors.deepOrangeAccent,
        indicatorColor: Colors.white,
        canvasColor: Colors.grey[100], // app background
        cardColor: Colors.amber,
        unselectedWidgetColor: Colors.grey[500],
        hoverColor: Colors.deepOrange,
        accentColor: Colors.white,
        splashColor: Colors.black,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[10],
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
        buttonColor: Colors.amber,
        accentColor: Colors.red,
        splashColor: Colors.white,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends GlobalState<WelcomePage> {

  @override
  void refreshState() {

  }

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
                padding: EdgeInsets.all(5),
                child: ColorFiltered(
                  child: Image.asset(
                    "images/logo.png",
                    width: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.width - 100 : 400,
                  ),
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).splashColor, BlendMode.modulate
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text(
                  AppLocalizations.of(context).translate("log_in_as"),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                  style: LeoTitleStyle()
                ),
              ),
              StadiumButton(
                icon: Icons.people,
                title: AppLocalizations.of(context).translate("club"),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      transitionDuration: Duration(milliseconds: 700),
                      pageBuilder: (BuildContext context, _, __) => LogIn()
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
