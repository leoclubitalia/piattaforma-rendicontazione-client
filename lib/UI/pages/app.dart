import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/guest.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/login.dart';
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
        backgroundColor: Colors.cyan,
        buttonColor: Colors.cyan,
        indicatorColor: Colors.white,
        canvasColor: Colors.grey[100], // app background
        cardColor: Colors.cyan,
        hoverColor: Colors.red,
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("app_title")
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: ColorFiltered(
                child: Image.asset(
                  "images/logo.png",
                  width: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.width - 40 : 400,
                ),
                colorFilter: ColorFilter.mode(
                    Theme.of(context).splashColor, BlendMode.modulate
                ),
              ),
            ),
            Text(AppLocalizations.of(context).translate("log_in_as")),
            StadiumButton(
              icon: Icons.people_sharp,
              title: AppLocalizations.of(context).translate("club"),
              onPressed: () {
                Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (BuildContext context, _, __) => LogIn()
                    )
                );
              },
            ),
            StadiumButton(
              icon: Icons.perm_identity_sharp,
              title: AppLocalizations.of(context).translate("guest"),
              onPressed: () {
                Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (BuildContext context, _, __) => Guest()
                    )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
