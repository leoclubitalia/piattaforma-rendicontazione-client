import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/SearchActivity.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/SearchService.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
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
    club = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB);
  }

  @override
  Widget build(BuildContext context) {
    if ( isGuest ) {
      Future.delayed(Duration.zero, () => showAlert(context));
      isGuest = false;
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(AppLocalizations.of(context).translate("search")),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context).translate("service"), icon: UIConstants.ICON_SERVICE),
              Tab(text: AppLocalizations.of(context).translate("activity"), icon: UIConstants.ICON_ACTIVITY),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchService(),
            SearchActivity(),
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