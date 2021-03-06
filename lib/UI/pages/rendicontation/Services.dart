import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/AddOrEditService.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/RoundedAppBar.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
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
    _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SEARCH_SERVICE_RESULT);
    if ( ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_JUST_ADDED) ) {
      ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_JUST_ADDED);
      showMessageDialog(context, AppLocalizations.of(context).translate("thanks").capitalize);
      refreshTable();
    }
    else if ( ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_JUST_DELETED_SERVICE) ) {
      Navigator.pop(context);
      _searchResult.remove(ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_JUST_DELETED_SERVICE));
      refreshTable();
    }
    else {
      if ( _searchResult != null ) {
        _isSearching = false;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_SERVICE_RESULT);
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
                if ( !isCircularMoment() ) {
                  loadSearch();
                }
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
                if ( !isCircularMoment() ) {
                  showAddService(context);
                }
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
                    ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_MESSAGE) ? AppLocalizations.of(context).translate(ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_MESSAGE)) : AppLocalizations.of(context).translate("no_results"),
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
                      bodyText: AppLocalizations.of(context).translate("info_add_service"),
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
        body: AddOrEditService(),
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
    ModelFacade.sharedInstance.searchServices(null, null, null, null, null, null, null, null, null, null, null, ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB), null, null, _currentPage);
    setState(() {
      _searchResult = null;
      _isSearching = true;
    });
  }

  void showMessageDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => MessageDialog(
        titleText: text,
        bodyText: "😊",
      ),
    );
  }

  void refreshTable() { // Isn't good, I know it
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _searchResult = null;
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SEARCH_SERVICE_RESULT);
        });
      });
    });
  }


}
