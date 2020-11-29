import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/AddActivity.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/ActivityTile.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/material.dart';


class Activities extends StatefulWidget {
  Activities({Key key}) : super(key: key);

  @override
  _Activities createState() => _Activities();
}

class _Activities extends GlobalState<Activities> {
  List<Activity> _searchResult;
  bool _isSearching = false;
  int _currentPage = 0;

  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;


  @override
  void initState() {
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_ACTIVITY_RESULT);
    ModelFacade.sharedInstance.loadAllSatisfactionDegrees();
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllTypesActivity();
    ModelFacade.sharedInstance.loadAllAreas();
    loadSearch();
    super.initState();
  }

  @override
  void refreshState() {
    _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SEARCH_ACTIVITY_RESULT);
    if ( ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_JUST_ADDED) ) {
      ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_JUST_ADDED);
    }
    else {
      if ( _searchResult != null ) {
        _isSearching = false;
      }
    }
  }

  bool isCircularMoment() {
    return !( ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_SATISFACTION_DEGREES) &&
        ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_DISTRICTS) &&
        ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_TYPE_ACTIVITY) &&
        ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_AREAS) ) || _isSearching;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(initialScrollOffset: _scrollOffset);
    return Scaffold(
      appBar: RoundedAppBar (
        title: AppLocalizations.of(context).translate("activity").capitalize,
        backable: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                loadSearch();
              },
              child: Icon(
                Icons.refresh_rounded,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showAddActivity(context);
              },
              child: Icon(
                  Icons.add_rounded
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            isCircularMoment() ?
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).buttonColor),
              ),
            ) :
            Column(
              children: <Widget>[
                _searchResult == null ?
                Padding(
                  padding: EdgeInsets.all(0),
                ) :
                _searchResult.length == 0 ?
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    AppLocalizations.of(context).translate(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_MESSAGE)),
                    style: LeoTitleStyle(),
                  ),
                ) :
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _searchResult.length + 1,
                      itemBuilder: (context, index) {
                        if ( index < _searchResult.length ) {
                          return ActivityTile(
                            activity: _searchResult[index],
                          );
                        }
                        else {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: CircularIconButton(
                              icon: Icons.arrow_downward_rounded,
                              onPressed: () {
                                loadMore();
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddActivity(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoundedDialog(
        title: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                AppLocalizations.of(context).translate("add").capitalize,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => MessageDialog(
                      titleText: AppLocalizations.of(context).translate("info").capitalize,
                      bodyText: AppLocalizations.of(context).translate("info_add_activity"),
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
        body: AddActivity(),
      ),
    );
  }

  void loadSearch() {
    _scrollOffset = 0;
    _currentPage = 0;
    _search();
  }

  void loadMore() {
    _scrollOffset = _scrollController.offset;
    _currentPage ++;
    _search();
  }

  void _search() {
    ModelFacade.sharedInstance.searchActivities(null, null, null, null, null, null, ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB), null, null, null, _currentPage);
    setState(() {
      _searchResult = null;
      _isSearching = true;
    });
  }


}
