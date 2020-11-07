import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputDropdown.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/ServiceTile.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class SearchService extends StatefulWidget {
  SearchService({Key key}) : super(key: key);


  @override
  _SearchService createState() => _SearchService();
}

class _SearchService extends GlobalState<SearchService> {
  String _title;
  String _otherAssociations;
  int _quantityParticipants;
  int _duration;
  int _minMoneyRaised;
  int _maxMoneyRaised;
  int _quantityServedPeople;
  District _district;
  String _impactValue;
  City _city;
  TypeService _type;
  CompetenceArea _area;
  Club _club;
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();

  List<String> _impactValues;
  List<District> _districts;
  List<City> _cities;
  List<TypeService> _types;
  List<CompetenceArea> _areas;
  List<Club> _clubs;

  List<Service> _searchResult;
  bool _isSearching = false;
  int _currentPage = 0;

  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();
  TextEditingController _dropDownImpactController = TextEditingController();
  TextEditingController _autocompleteDistrictController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _autocompleteTypeServiceController = TextEditingController();
  TextEditingController _autocompleteCompetenceAreaController = TextEditingController();
  TextEditingController _autocompleteClubController = TextEditingController();
  TextEditingController _inputFieldTitleController = TextEditingController();
  TextEditingController _inputFieldParticipantsController = TextEditingController();
  TextEditingController _inputFieldDurationController = TextEditingController();
  TextEditingController _inputFieldMinMoneyRaisedController = TextEditingController();
  TextEditingController _inputFieldMaxMoneyRaisedController = TextEditingController();
  TextEditingController _inputFieldServedPeopleController = TextEditingController();
  TextEditingController _inputFieldOtherAssociationsController = TextEditingController();


  _SearchService() {
    ModelFacade.sharedInstance.loadAllImpactValues();
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllCities();
    ModelFacade.sharedInstance.loadAllTypesService();
    ModelFacade.sharedInstance.loadAllAreas();
    ModelFacade.sharedInstance.loadAllClubs();
  }

  @override
  void refreshState() {
    _impactValues = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_IMPACT_VALUES);
    _districts = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_DISTRICTS);
    _cities = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CITIES);
    _types = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_SERVICE);
    _areas = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_AREAS);
    _clubs = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CLUBS);
    if ( _impactValues != null ) {
      _impactValue = _impactValues[0];
    }
    _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SERVICE_SEARCH_RESULT);
    if ( _searchResult != null ) {
      _isSearching = false;
    }
  }

  bool isCircularMoment() {
    return !(_impactValues != null && _districts != null && _cities != null && _types != null && _areas != null && _clubs != null) || _isSearching;
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
              child: CircularProgressIndicator(),
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
                    AppLocalizations.of(context).translate(ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_MESSAGE)),
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
                        labelText: AppLocalizations.of(context).translate("compentece_area"),
                        controller: _autocompleteCompetenceAreaController,
                        onSuggestion: (String pattern) async {
                          return await ModelFacade.sharedInstance.suggestAreas(pattern);
                        },
                        onSelect: (suggestion) {
                          _autocompleteCompetenceAreaController.text = suggestion.toString();
                          _area = suggestion;
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
                        controller: _inputFieldParticipantsController,
                        keyboardType: TextInputType.number,
                        onSubmit: (String value) {
                          if ( value == null || value == "" ) {
                            _quantityParticipants = null;
                          }
                          else {
                            _quantityParticipants = int.parse(value);
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("duration"),
                        controller: _inputFieldDurationController,
                        keyboardType: TextInputType.number,
                        onSubmit: (String value) {
                          if ( value == null || value == "" ) {
                            _duration = null;
                          }
                          else {
                            _duration = int.parse(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("min_money_raised"),
                        controller: _inputFieldMinMoneyRaisedController,
                        keyboardType: TextInputType.number,
                        onSubmit: (String value) {
                          if ( value == null || value == "" ) {
                            _minMoneyRaised = null;
                          }
                          else {
                            _minMoneyRaised = int.parse(value);
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("max_money_raised"),
                        controller: _inputFieldMaxMoneyRaisedController,
                        keyboardType: TextInputType.number,
                        onSubmit: (String value) {
                          if ( value == null || value == "" ) {
                            _maxMoneyRaised = null;
                          }
                          else {
                            _maxMoneyRaised = int.parse(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputDropdown(
                        labelText: AppLocalizations.of(context).translate("impact"),
                        controller: _dropDownImpactController,
                        items: _impactValues,
                        onChanged: (String value) {
                          _impactValue = value;
                          _dropDownImpactController.text = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("quantity_served_people"),
                        controller: _inputFieldServedPeopleController,
                        keyboardType: TextInputType.number,
                        onSubmit: (String value) {
                          if ( value == null || value == "" ) {
                            _quantityServedPeople = null;
                          }
                          else {
                            _quantityServedPeople = int.parse(value);
                          }
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
                      child: InputAutocomplete(
                        labelText: AppLocalizations.of(context).translate("type_service"),
                        controller: _autocompleteTypeServiceController,
                        onSuggestion: (String pattern) async {
                          return await ModelFacade.sharedInstance.suggestTypesService(pattern);
                        },
                        onSelect: (suggestion) {
                          _autocompleteTypeServiceController.text = suggestion.toString();
                          _type = suggestion;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InputField(
                        labelText: AppLocalizations.of(context).translate("other_associations"),
                        controller: _inputFieldOtherAssociationsController,
                        onSubmit: (String value) {
                          _otherAssociations = value;
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
    if ( _impactValue != null ) {
      _dropDownImpactController.text = _impactValue;
    }
    if ( _district != null ) {
      _autocompleteDistrictController.text = _district.name;
    }
    if ( _city != null ) {
      _autocompleteCityController.text = _city.name;
    }
    if ( _type != null ) {
      _autocompleteTypeServiceController.text = _type.title;
    }
    if ( _area != null ) {
      _autocompleteCompetenceAreaController.text = _area.title;
    }
    if ( _club != null ) {
      _autocompleteClubController.text = _club.name;
    }
    if ( _title != null ) {
      _inputFieldTitleController.text = _title;
    }
    if ( _quantityParticipants != null ) {
      _inputFieldParticipantsController.text = _quantityParticipants.toString();
    }
    if ( _duration != null ) {
      _inputFieldDurationController.text = _duration.toString();
    }
    if ( _minMoneyRaised != null ) {
      _inputFieldMinMoneyRaisedController.text = _minMoneyRaised.toString();
    }
    if ( _maxMoneyRaised != null ) {
      _inputFieldMaxMoneyRaisedController.text = _maxMoneyRaised.toString();
    }
    if ( _quantityServedPeople != null ) {
      _inputFieldServedPeopleController.text = _quantityServedPeople.toString();
    }
    if ( _otherAssociations != null ) {
      _inputFieldOtherAssociationsController.text = _otherAssociations.toString();
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
    ModelFacade.sharedInstance.searchServices(_title, _otherAssociations, _quantityParticipants, _duration, _minMoneyRaised, _maxMoneyRaised, _quantityServedPeople, _district, _impactValue, _city, _type, _area, _club, _startDate, _endDate, _currentPage);
    setState(() {
      _isSearching = true;
    });
  }


}
