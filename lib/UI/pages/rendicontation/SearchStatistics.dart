import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Statistics.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';


class SearchStatistics extends StatefulWidget {
  SearchStatistics({Key key}) : super(key: key);


  @override
  _SearchStatistics createState() => _SearchStatistics();
}

class _SearchStatistics extends GlobalState<SearchStatistics> {
  District _district;
  Club _club;

  List<District> _districts;
  List<Club> _clubs;
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();

  Statistics _searchResult;
  bool _isSearching = false;

  TextEditingController _autocompleteDistrictController = TextEditingController();
  TextEditingController _autocompleteClubController = TextEditingController();


  @override
  void initState() {
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_GET_STATISTICS_RESULT);
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllClubs();
    super.initState();
  }

  @override
  void refreshState() {
    _districts = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_DISTRICTS);
    _clubs = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CLUBS);
    _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_GET_STATISTICS_RESULT);
    if ( _searchResult != null ) {
      _isSearching = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_GET_STATISTICS_RESULT);
  }

  bool isCircularMoment() {
    return !(_districts != null && _clubs != null) || _isSearching;
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              IgnorePointer(
                ignoring: isCircularMoment(),
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        children: [
                          Flexible(
                            child: InputAutocomplete(
                              labelText: AppLocalizations.of(context).translate("club"),
                              controller: _autocompleteClubController,
                              onSuggestion: (String pattern) async {
                                return await ModelFacade.sharedInstance.suggestClubs(pattern);
                              },
                              onSelect: (suggestion) {
                                _autocompleteClubController.text = suggestion.toString();
                                _club = suggestion;
                              },
                            ),
                          ),
                          Flexible(
                            child: InputAutocomplete(
                              labelText: AppLocalizations.of(context).translate("district"),
                              controller: _autocompleteDistrictController,
                              onSuggestion: (String pattern) async {
                                return await ModelFacade.sharedInstance.suggestDistricts(pattern);
                              },
                              onSelect: (suggestion) {
                                _autocompleteDistrictController.text = suggestion.toString();
                                _district = suggestion;
                              },
                            ),
                          ),
                          CircularIconButton(
                            onPressed: () {
                              loadSearch();
                            },
                            icon: Icons.search_rounded,
                          ),
                          CircularIconButton(
                            onPressed: () {
                              showAdvancedSearch(context);
                            },
                            icon: Icons.add,
                          ),
                        ],
                      ),
                    ),
                    _searchResult == null ?
                    Padding(
                      padding: EdgeInsets.all(0),
                    ) :
                    SingleChildScrollView (
                      child: Text(_searchResult.members.toString()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadSearch() {
    if ( _autocompleteClubController.text == null || _autocompleteClubController.text == "" ) {
      _club = null;
    }
    if ( _autocompleteDistrictController.text == null || _autocompleteDistrictController.text == "" ) {
      _district = null;
    }
    ModelFacade.sharedInstance.getStatistics(_club, _district, _startDate, _endDate);
    setState(() {
      _searchResult = null;
      _isSearching = true;
    });
  }

  void showAdvancedSearch(BuildContext context) {

  }


}
