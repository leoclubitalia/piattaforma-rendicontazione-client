import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputDropdown.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/ActivityTile.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class SearchActivity extends StatefulWidget {
  SearchActivity({Key key}) : super(key: key);


  @override
  _SearchActivity createState() => _SearchActivity();
}

class _SearchActivity extends GlobalState<SearchActivity> {
  String _title;
  int _quantityLeo;
  District _district;
  City _city;
  TypeActivity _type;
  Club _club;
  String _lionsParticipation;
  String _satisfactionDegree;
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();

  List<String> _satisfactionDegrees;
  List<String> _lionsParticipationsValues;
  List<District> _districts;
  List<TypeActivity> _types;
  List<Club> _clubs;

  List<Activity> _searchResult;
  bool _isSearching = false;
  int _currentPage = 0;

  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();
  TextEditingController _dropDownSatisfactionDegreeController = TextEditingController();
  TextEditingController _dropDownLionsParticipationController = TextEditingController();
  TextEditingController _autocompleteDistrictController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _autocompleteTypeActivityController = TextEditingController();
  TextEditingController _autocompleteClubController = TextEditingController();
  TextEditingController _inputFieldTitleController = TextEditingController();
  TextEditingController _inputFieldQuantityLeoController = TextEditingController();


  _SearchActivity() {
    ModelFacade.sharedInstance.loadAllSatisfactionDegrees();
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllTypesActivity();
    ModelFacade.sharedInstance.loadAllClubs();
    ModelFacade.sharedInstance.loadAllBools();
  }

  @override
  void refreshState() {
    _satisfactionDegrees = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES);
    _lionsParticipationsValues = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_BOOLS);
    _districts = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_DISTRICTS);
    _types = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_ACTIVITY);
    _clubs = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CLUBS);
    if ( _satisfactionDegrees != null ) {
      _satisfactionDegree = _satisfactionDegrees[0];
    }
    _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SEARCH_ACTIVITY_RESULT);
    if ( _searchResult != null ) {
      _isSearching = false;
    }
  }

  bool isCircularMoment() {
    return !(_satisfactionDegrees != null && _districts != null && _types != null && _clubs != null) || _isSearching;
  }

  @override
  Widget build(BuildContext context) {
    _startDateTextController.text = _startDate.day.toString() + "/" + _startDate.month.toString() + "/" + _startDate.year.toString();
    _endDateTextController.text = _endDate.day.toString() + "/" + _endDate.month.toString() + "/" + _endDate.year.toString();
    return Scaffold(
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
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ListView.builder(
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

  void showAdvancedSearch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(AppLocalizations.of(context).translate("advanced_search")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.2,
            child: Column(
              children: [
                Row(
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
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("title"),
                        controller: _inputFieldTitleController,
                        onSubmit: (String value) {
                          _title = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: InputAutocomplete(
                        labelText: AppLocalizations.of(context).translate("type_activity"),
                        controller: _autocompleteTypeActivityController,
                        onSuggestion: (String pattern) async {
                          return await ModelFacade.sharedInstance.suggestTypesActivity(pattern);
                        },
                        onSelect: (suggestion) {
                          _autocompleteTypeActivityController.text = suggestion.toString();
                          _type = suggestion;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputButton(
                        text: AppLocalizations.of(context).translate("start_date"),
                        controller: _startDateTextController,
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2000, 1, 1),
                            maxTime: DateTime.now(),
                            onConfirm: (date) {
                              _startDate = date;
                              _startDateTextController.text = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.it
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: InputButton(
                        text: AppLocalizations.of(context).translate("end_date"),
                        controller: _endDateTextController,
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2000, 1, 1),
                            maxTime: DateTime.now(),
                            onConfirm: (date) {
                              _endDate = date;
                              _endDateTextController.text = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.it
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("quantity_participants"),
                        controller: _inputFieldQuantityLeoController,
                        keyboardType: TextInputType.number,
                        onSubmit: (String value) {
                          if ( value == null || value == "" ) {
                            _quantityLeo = null;
                          }
                          else {
                            _quantityLeo = int.parse(value);
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: InputDropdown(
                        labelText: AppLocalizations.of(context).translate("lions_participation"),
                        controller: _dropDownLionsParticipationController,
                        items: _lionsParticipationsValues,
                        onChanged: (String value) {
                          _lionsParticipation = value;
                          _dropDownLionsParticipationController.text = value;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputAutocomplete(
                        labelText: AppLocalizations.of(context).translate("city"),
                        controller: _autocompleteCityController,
                        onSuggestion: (String pattern) async {
                          return await ModelFacade.sharedInstance.suggestCities(pattern);
                        },
                        onSelect: (suggestion) {
                          _autocompleteCityController.text = suggestion.toString();
                          _city = suggestion;
                        },
                      ),
                    ),
                    Flexible(
                      child: InputDropdown(
                        labelText: AppLocalizations.of(context).translate("satisfaction_degree"),
                        controller: _dropDownSatisfactionDegreeController,
                        items: _satisfactionDegrees,
                        onChanged: (String value) {
                          _satisfactionDegree = value;
                          _dropDownSatisfactionDegreeController.text = value;
                        },
                      ),
                    ),
                    CircularIconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        loadSearch();
                      },
                      icon: Icons.search_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if ( _satisfactionDegree != null ) {
      _dropDownSatisfactionDegreeController.text = _satisfactionDegree;
    }
    if ( _lionsParticipation != null ) {
      _dropDownLionsParticipationController.text = _lionsParticipation.toString();
    }
    if ( _district != null ) {
      _autocompleteDistrictController.text = _district.name;
    }
    if ( _city != null ) {
      _autocompleteCityController.text = _city.name;
    }
    if ( _type != null ) {
      _autocompleteTypeActivityController.text = _type.title;
    }
    if ( _club != null ) {
      _autocompleteClubController.text = _club.name;
    }
    if ( _title != null ) {
      _inputFieldTitleController.text = _title;
    }
    if ( _quantityLeo != null ) {
      _inputFieldQuantityLeoController.text = _quantityLeo.toString();
    }
  }

  void loadSearch() {
    _currentPage = 0;
    _search();
  }

  void loadMore() {
    _currentPage ++;
    _search();
  }

  void _search() {
    if ( _autocompleteClubController.text == null || _autocompleteClubController.text == "" ) {
      _club = null;
    }
    if ( _autocompleteDistrictController.text == null || _autocompleteDistrictController.text == "" ) {
      _district = null;
    }
    if ( _autocompleteCityController.text == null || _autocompleteCityController.text == "" ) {
      _city = null;
    }
    if ( _autocompleteTypeActivityController.text == null || _autocompleteTypeActivityController.text == "" ) {
      _type = null;
    }
    ModelFacade.sharedInstance.searchActivities(_title, _quantityLeo, _district, _satisfactionDegree, _city, _type, _club, _startDate, _endDate, _lionsParticipation, _currentPage);
    setState(() {
      _searchResult = null;
      _isSearching = true;
    });
  }


}
