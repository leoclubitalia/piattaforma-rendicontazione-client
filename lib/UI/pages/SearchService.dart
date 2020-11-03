import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputDropdown.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
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
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();

  List<String> _impactValues;
  List<District> _districts;
  List<City> _cities;
  List<TypeService> _types;
  List<CompetenceArea> _areas;
  List<Club> _clubs;
  String _dropdownValue;

  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();
  TextEditingController _dropDownImpactController = TextEditingController();
  TextEditingController _autocompleteDistrictController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _autocompleteTypeServiceController = TextEditingController();
  TextEditingController _autocompleteCompetenceAreaController = TextEditingController();
  TextEditingController _autocompleteClubController = TextEditingController();


  @override
  void refreshState() {
    _impactValues = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_IMPACT_VALUES);
    _districts = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_DISTRICTS);
    _cities = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CITIES);
    _types = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_SERVICE);
    _areas = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_AREAS);
    _clubs = ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_CLUBS);
    if ( _impactValues != null ) {
      _dropdownValue = _impactValues[0];
    }
  }

  bool isLoading() {
    return !(_impactValues != null && _districts != null && _cities != null && _types != null && _areas != null && _clubs != null);
  }

  @override
  Widget build(BuildContext context) {
    ModelFacade.sharedInstance.loadAllImpactValues();
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllCities();
    ModelFacade.sharedInstance.loadAllTypesService();
    ModelFacade.sharedInstance.loadAllAreas();
    ModelFacade.sharedInstance.loadAllClubs();
    _startDateTextController.text = _startDate.day.toString() + "/" + _startDate.month.toString() + "/" + _startDate.year.toString();
    _endDateTextController.text = _endDate.day.toString() + "/" + _endDate.month.toString() + "/" + _endDate.year.toString();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: isLoading() ?
        Center(
          child: CircularProgressIndicator(),
        ) :
        GridView.count(
          shrinkWrap: true,
          childAspectRatio: 1 / 0.25,
          crossAxisCount: MediaQuery.of(context).size.width > 650 ? 4 : 2,
          children: [
            InputField(
              labelText: AppLocalizations.of(context).translate("title"),
              onSubmit: (String value) {
                _title = value;
              },
            ),
            InputField(
              labelText: AppLocalizations.of(context).translate("other_associations"),
              onSubmit: (String value) {
                _otherAssociations = value;
              },
            ),
            InputButton(
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
            InputButton(
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
            InputField(
              labelText: AppLocalizations.of(context).translate("quantity_participants"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _quantityParticipants = int.parse(value);
              },
            ),
            InputField(
              labelText: AppLocalizations.of(context).translate("duration"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _duration = int.parse(value);
              },
            ),
            InputField(
              labelText: AppLocalizations.of(context).translate("min_money_raised"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _minMoneyRaised = int.parse(value);
              },
            ),
            InputField(
              labelText: AppLocalizations.of(context).translate("max_money_raised"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _maxMoneyRaised = int.parse(value);
              },
            ),
            InputDropdown(
              labelText: AppLocalizations.of(context).translate("impact"),
              controller: _dropDownImpactController,
              items: _impactValues,
              onChanged: (String value) {
                _dropdownValue = value;
                _dropDownImpactController.text = value;
              },
            ),
            InputField(
              labelText: AppLocalizations.of(context).translate("quantity_served_people"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _quantityServedPeople = int.parse(value);
              },
            ),
            InputAutocomplete(
              labelText: AppLocalizations.of(context).translate("city"),
              controller: _autocompleteCityController,
              onSuggestion: (String pattern) {
                return _cities; //TODO
              },
              onSelect: (suggestion) {
                _autocompleteCityController.text = suggestion.toString();
              },
            ),
            InputAutocomplete(
              labelText: AppLocalizations.of(context).translate("type_service"),
              controller: _autocompleteTypeServiceController,
              onSuggestion: (String pattern) {
                return _types; //TODO
              },
              onSelect: (suggestion) {
                _autocompleteTypeServiceController.text = suggestion.toString();
              },
            ),
            InputAutocomplete(
              labelText: AppLocalizations.of(context).translate("compentece_area"),
              controller: _autocompleteCompetenceAreaController,
              onSuggestion: (String pattern) {
                return _areas; //TODO
              },
              onSelect: (suggestion) {
                _autocompleteCompetenceAreaController.text = suggestion.toString();
              },
            ),
            InputAutocomplete(
              labelText: AppLocalizations.of(context).translate("district"),
              controller: _autocompleteDistrictController,
              onSuggestion: (String pattern) {
                return _districts; //TODO
              },
              onSelect: (suggestion) {
                _autocompleteDistrictController.text = suggestion.toString();
              },
            ),
            InputAutocomplete(
              labelText: AppLocalizations.of(context).translate("club"),
              controller: _autocompleteClubController,
              onSuggestion: (String pattern) {
                return _clubs; //TODO
              },
              onSelect: (suggestion) {
                _autocompleteClubController.text = suggestion.toString();
              },
            ),
            StadiumButton(
              title: AppLocalizations.of(context).translate("search"),
              onPressed: () {
                //TODO load search
              },
              icon: Icons.search_rounded,
            )
          ],
        ),
      ),
    );
  }


}

/*
uggestionsCallback: (pattern) async {
              return await ["ya", "yb", "yc"];//TODO call server to search
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion[0]),
              );
            },
            onSuggestionSelected: (suggestion) {

            },
 */