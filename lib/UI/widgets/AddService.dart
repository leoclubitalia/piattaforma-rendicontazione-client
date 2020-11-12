import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/CircularCheckBoxTitle.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputDropdown.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/StringCapitalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class AddService extends StatefulWidget {
  AddService({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Activities createState() => _Activities();
}

class _Activities extends GlobalState<AddService> {
  String _title;
  String _otherAssociations;
  String _description;
  int _quantityParticipants;
  int _duration;
  int _minMoneyRaised;
  int _maxMoneyRaised;
  int _quantityServedPeople;
  String _satisfactionDegree;
  City _city;
  List<TypeService> _types;
  List<CompetenceArea> _areas;
  DateTime _date = DateTime.now();

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _dropDownSatisfactionDegreeController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _inputFieldTitleController = TextEditingController();
  TextEditingController _inputFieldParticipantsController = TextEditingController();
  TextEditingController _inputFieldDurationController = TextEditingController();
  TextEditingController _inputFieldMoneyRaisedController = TextEditingController();
  TextEditingController _inputFieldServedPeopleController = TextEditingController();
  TextEditingController _inputFieldOtherAssociationsController = TextEditingController();
  TextEditingController _inputFieldDescriptionController = TextEditingController();

  List<String> _allSatisfactionDegrees;
  List<TypeService> _allTypes;
  List<CompetenceArea> _allAreas;


  @override
  void refreshState() {
    _allSatisfactionDegrees = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES));
    _allTypes = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_SERVICE));
    _allAreas = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_AREAS));
    if ( _allSatisfactionDegrees != null ) {
      _allSatisfactionDegrees.removeAt(0);
      _satisfactionDegree = _allSatisfactionDegrees[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
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
                child: InputButton(
                  text: AppLocalizations.of(context).translate("date"),
                  controller: _dateTextController,
                  onPressed: () {
                    DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime.now(),
                        onConfirm: (date) {
                          _date = date;
                          _dateTextController.text = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
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
                  labelText: AppLocalizations.of(context).translate("description"),
                  controller: _inputFieldDescriptionController,
                  multiline: true,
                  onSubmit: (String value) {
                    if ( value == null || value == "" ) {
                      _description = null;
                    }
                    else {
                      _description = value;
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
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("money_raised"),
                  controller: _inputFieldMoneyRaisedController,
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
              Flexible(
                child: InputDropdown(
                  labelText: AppLocalizations.of(context).translate("satisfaction_degree"),
                  controller: _dropDownSatisfactionDegreeController,
                  items: _allSatisfactionDegrees,
                  onChanged: (String value) {
                    _satisfactionDegree = value;
                    _dropDownSatisfactionDegreeController.text = value;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              children: [
                Container(
                  width: 55,
                  child: Text(
                    AppLocalizations.of(context).translate("areas").capitalize + ":",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  children: [
                    for( var item in _allAreas )
                      CircularCheckBoxTitle(
                        title: item.title,
                        value: item.selected,
                        onChanged: (bool x) {
                          setState(() {
                            item.selected = !item.selected;
                          });
                        }
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              children: [
                Container(
                  width: 55,
                  child: Text(
                    AppLocalizations.of(context).translate("type_service").capitalize + ":",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  children: [
                    for( var item in _allTypes )
                      CircularCheckBoxTitle(
                          title: item.title,
                          value: item.selected,
                          onChanged: (bool x) {
                            setState(() {
                              item.selected = !item.selected;
                            });
                          }
                      ),
                  ],
                ),
              ],
            ),
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
                  //TODO add
                },
                icon: Icons.add_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }


}