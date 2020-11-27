import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/AddService.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/ServiceTile.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/material.dart';


class Services extends StatefulWidget {
  Services({Key key}) : super(key: key);

  @override
  _Services createState() => _Services();
}

class _Services extends GlobalState<Services> {
  List<Service> _searchResult;
  bool _isSearching = false;
  int _currentPage = 0;

  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;


  @override
  void initState() {
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_SERVICE_RESULT);
    ModelFacade.sharedInstance.loadAllSatisfactionDegrees();
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllTypesService();
    ModelFacade.sharedInstance.loadAllAreas();
    loadSearch();
    super.initState();
  }

  @override
  void refreshState() {
    if ( ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_JUST_ADDED) && ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_JUST_ADDED) ) {
      loadSearch();
    }
    else {
      _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SEARCH_SERVICE_RESULT);
      if ( _searchResult != null ) {
        _isSearching = false;
      }
    }
  }

  bool isCircularMoment() {
    return !( ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_SATISFACTION_DEGREES) &&
              ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_DISTRICTS) &&
              ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_TYPE_SERVICE) &&
              ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_ALL_AREAS) ) || _isSearching;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(initialScrollOffset: _scrollOffset);
    return Scaffold(
      appBar: RoundedAppBar (
        title: AppLocalizations.of(context).translate("service").capitalize,
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
                showAddService(context);
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
            Padding(padding: EdgeInsets.all(0)),
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
                          return ServiceTile(
                            service: _searchResult[index],
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

  void showAddService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoundedDialog(
        title: Text(
          AppLocalizations.of(context).translate("add").capitalize,
          textAlign: TextAlign.center,
        ),
        body: AddService(),
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
    ModelFacade.sharedInstance.searchServices(null, null, null, null, null, null, null, null, null, null, null, null, ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB), null, null, _currentPage);
    setState(() {
      _searchResult = null;
      _isSearching = true;
    });
  }


}
