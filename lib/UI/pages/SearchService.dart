import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/ServiceTile.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';


class SearchService extends StatefulWidget {
  SearchService({Key key}) : super(key: key);


  @override
  _SearchService createState() => _SearchService();
}

class _SearchService extends GlobalState<SearchService> {
  String _title;
  String _otherAssociations;
  String _moneyOrMaterialCollected;
  int _quantityParticipants;
  int _duration;
  int _quantityServedPeople;
  District _district;
  SatisfactionDegree _satisfactionDegree;
  City _city;
  TypeService _type;
  CompetenceArea _area;
  Club _club;
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();

  List<SatisfactionDegree> _satisfactionDegrees;
  List<District> _districts;
  List<TypeService> _types;
  List<CompetenceArea> _areas;
  List<Club> _clubs;

  SatisfactionDegree _allDegrees;
  List<Service> _searchResult;
  bool _isSearching = false;
  int _currentPage = 0;

  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();
  TextEditingController _autocompleteSatisfactionDegreeController = TextEditingController();
  TextEditingController _autocompleteDistrictController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _autocompleteTypeServiceController = TextEditingController();
  TextEditingController _autocompleteCompetenceAreaController = TextEditingController();
  TextEditingController _autocompleteClubController = TextEditingController();
  TextEditingController _inputFieldTitleController = TextEditingController();
  TextEditingController _inputFieldParticipantsController = TextEditingController();
  TextEditingController _inputFieldDurationController = TextEditingController();
  TextEditingController _inputFieldMoneyOrMaterialCollectedController = TextEditingController();
  TextEditingController _inputFieldServedPeopleController = TextEditingController();
  TextEditingController _inputFieldOtherAssociationsController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;


  @override
  void initState() {
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_SERVICE_RESULT);
    ModelFacade.sharedInstance.loadAllSatisfactionDegrees();
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllTypesService();
    ModelFacade.sharedInstance.loadAllAreas();
    ModelFacade.sharedInstance.loadAllClubs();
    super.initState();
  }

  @override
  void refreshState() {
    if ( ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES) != null ) {
      _satisfactionDegrees = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES));
    }
    _districts = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_DISTRICTS);
    _types = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_SERVICE);
    _areas = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_AREAS);
    _clubs = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CLUBS);
    if ( _satisfactionDegrees != null && _allDegrees != null && !_satisfactionDegrees.contains(_allDegrees) ) {
      _satisfactionDegrees.add(_allDegrees);
      _satisfactionDegree = _allDegrees;
    }
    _searchResult = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_SEARCH_SERVICE_RESULT);
    if ( _searchResult != null ) {
      _isSearching = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_SERVICE_RESULT);
  }

  bool isCircularMoment() {
    return !(_satisfactionDegrees != null && _districts != null && _types != null && _areas != null && _clubs != null) || _isSearching;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(initialScrollOffset: _scrollOffset);
    if ( _allDegrees == null ) {
      _allDegrees = SatisfactionDegree(name: AppLocalizations.of(context).translate("all"));
    }
    _startDateTextController.text = _startDate.toStringSlashed();
    _endDateTextController.text = _endDate.toStringSlashed();
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
            IgnorePointer(
              ignoring: isCircularMoment(),
              child: Column(
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
                      child: ListView.builder(
                        itemCount: _searchResult.length + 1,
                        controller: _scrollController,
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
            ),
          ],
        ),
      ),
    );
  }

  void showAdvancedSearch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoundedDialog(
        title: Text(
          AppLocalizations.of(context).translate("advanced_search"),
          textAlign: TextAlign.center,
        ),
        body: Container(
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
                      maxLength: 50,
                      controller: _inputFieldTitleController,
                      onChanged: (String value) {
                        _title = value;
                      },
                    ),
                  ),
                  Flexible(
                    child: InputAutocomplete(
                      labelText: AppLocalizations.of(context).translate("competence_area"),
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
                            _startDateTextController.text = _startDate.toStringSlashed();
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
                            _endDateTextController.text = _startDate.toStringSlashed();
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
                      onChanged: (String value) {
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
                      onChanged: (String value) {
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
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: InputAutocomplete(
                      labelText: AppLocalizations.of(context).translate("satisfaction_degree"),
                      controller: _autocompleteSatisfactionDegreeController,
                      typeable: false,
                      onSuggestion: (String pattern) {
                        return _satisfactionDegrees;
                      },
                      onSelect: (suggestion) {
                        _autocompleteSatisfactionDegreeController.text = suggestion.toString();
                        _satisfactionDegree = suggestion;
                      },
                    ),
                  ),
                  Flexible(
                    child: InputField(
                      labelText: AppLocalizations.of(context).translate("quantity_served_people"),
                      controller: _inputFieldServedPeopleController,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
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
                    child: InputField(
                      labelText: AppLocalizations.of(context).translate("money_or_material_collected"),
                      maxLength: 100,
                      controller: _inputFieldMoneyOrMaterialCollectedController,
                      onChanged: (String value) {
                        if ( value == null || value == "" ) {
                          _moneyOrMaterialCollected = null;
                        }
                        else {
                          _moneyOrMaterialCollected = value;
                        }
                      },
                    ),
                  ),
                  Flexible(
                    child: InputAutocomplete(
                      labelText: AppLocalizations.of(context).translate("type_service"),
                      controller: _autocompleteTypeServiceController,
                      typeable: false,
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
                      maxLength: 400,
                      controller: _inputFieldOtherAssociationsController,
                      onChanged: (String value) {
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
      ),
    );
    if ( _satisfactionDegree != null ) {
      _autocompleteSatisfactionDegreeController.text = _satisfactionDegree.name;
    }
    if ( _district != null ) {
      _autocompleteDistrictController.text = _district.name;
    }
    if ( _city != null ) {
      _autocompleteCityController.text = _city.name;
    }
    if ( _type != null ) {
      _autocompleteTypeServiceController.text = _type.name;
    }
    if ( _area != null ) {
      _autocompleteCompetenceAreaController.text = _area.name;
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
    if ( _moneyOrMaterialCollected != null ) {
      _inputFieldMoneyOrMaterialCollectedController.text = _moneyOrMaterialCollected;
    }
    if ( _quantityServedPeople != null ) {
      _inputFieldServedPeopleController.text = _quantityServedPeople.toString();
    }
    if ( _otherAssociations != null ) {
      _inputFieldOtherAssociationsController.text = _otherAssociations.toString();
    }
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
    if ( _autocompleteClubController.text == null || _autocompleteClubController.text == "" ) {
      _club = null;
    }
    if ( _autocompleteDistrictController.text == null || _autocompleteDistrictController.text == "" ) {
      _district = null;
    }
    if ( _autocompleteCityController.text == null || _autocompleteCityController.text == "" ) {
      _city = null;
    }
    if ( _autocompleteTypeServiceController.text == null || _autocompleteTypeServiceController.text == "" ) {
      _type = null;
    }
    if ( _autocompleteCompetenceAreaController.text == null || _autocompleteCompetenceAreaController.text == "" ) {
      _area = null;
    }
    ModelFacade.sharedInstance.searchServices(_title, _otherAssociations, _quantityParticipants, _duration, _moneyOrMaterialCollected, _quantityServedPeople, _district, _satisfactionDegree == _allDegrees ? null : _satisfactionDegree, _city, _type, _area, _club, _startDate, _endDate, _currentPage);
    setState(() {
      _searchResult = null;
      _isSearching = true;
    });
  }


}
