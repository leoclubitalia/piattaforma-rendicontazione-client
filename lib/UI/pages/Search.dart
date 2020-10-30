import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  bool isGuest;


  Search(bool isGuest) {
    this.isGuest = isGuest;
  }

  @override
  _Search createState() => _Search(isGuest);
}

class _Search extends GlobalState<Search> {
  bool isGuest;
  Club club;

  _Search(this.isGuest);

  @override
  void refreshState() {
    club = ModelFacade.sharedInstance.appState.getClub();
  }

  @override
  Widget build(BuildContext context) {
    if ( isGuest ) {
      Future.delayed(Duration.zero, () => showAlert(context));
    }
    return Scaffold(
      appBar: RoundedAppBar(
        title: AppLocalizations.of(context).translate("search"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("search page") //TODO
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoundedDialog(
        text: AppLocalizations.of(context).translate("description_search_for_guest"),
      )
    );
  }


}