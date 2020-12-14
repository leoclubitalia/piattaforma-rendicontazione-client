import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/Welcome.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';


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
        dividerColor: UIConstants.COLOR_LIGHT_NAV_BAR_BACKGROUND,
        toggleableActiveColor: UIConstants.COLOR_LIGHT_NAV_BAR_TEXT,
        canvasColor: UIConstants.COLOR_LIGHT_APP_BACKGROUND,
        primaryColor: UIConstants.COLOR_LIGHT_PRIMARY,
        backgroundColor: UIConstants.COLOR_LIGHT_BACKGROUND,
        buttonColor: UIConstants.COLOR_LIGHT_BUTTON,
        indicatorColor: UIConstants.COLOR_LIGHT_INDICATOR,
        cardColor: UIConstants.COLOR_LIGHT_CARD,
        hoverColor: UIConstants.COLOR_LIGHT_HOVER,
        accentColor: UIConstants.COLOR_LIGHT_ACCENT,
        splashColor: UIConstants.COLOR_LIGHT_INVERSE_PRIMARY,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: UIConstants.COLOR_DARK_NAV_BAR_BACKGROUND,
        toggleableActiveColor: UIConstants.COLOR_DARK_NAV_BAR_TEXT,
        canvasColor: UIConstants.COLOR_DARK_APP_BACKGROUND,
        primaryColor: UIConstants.COLOR_DARK_PRIMARY,
        backgroundColor: UIConstants.COLOR_DARK_BACKGROUND,
        buttonColor: UIConstants.COLOR_DARK_BUTTON,
        accentColor: UIConstants.COLOR_DARK_ACCENT,
        splashColor: UIConstants.COLOR_DARK_INVERSE_PRIMARY,
      ),
      home: Welcome(),
    );
  }


}

