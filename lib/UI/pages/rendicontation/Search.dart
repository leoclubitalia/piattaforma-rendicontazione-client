import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/SearchActivity.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/SearchService.dart';
import 'package:RendicontationPlatformLeo_Client/UI/pages/rendicontation/SearchStatistics.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(AppLocalizations.of(context).translate("search").capitalize),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => MessageDialog(
                      titleText: AppLocalizations.of(context).translate("info").capitalize,
                      bodyText: AppLocalizations.of(context).translate("info_search"),
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
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context).translate("service"), icon: Icon(UIConstants.ICON_SERVICE)),
              Tab(text: AppLocalizations.of(context).translate("activity"), icon: Icon(UIConstants.ICON_ACTIVITY)),
              Tab(text: AppLocalizations.of(context).translate("statistics"), icon: Icon(UIConstants.ICON_STATISTICS)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchService(),
            SearchActivity(),
            SearchStatistics(),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MessageDialog(
        titleText: AppLocalizations.of(context).translate("welcome") + "!",
        bodyText: AppLocalizations.of(context).translate("description_search_for_guest"),
      )
    );
  }


}