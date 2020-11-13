import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/CircularCheckBoxTitle.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputDropdown.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/StringCapitalization.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/DateFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class AddService extends StatefulWidget {
  AddService({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Activities createState() => _Activities();
}

class _Activities extends GlobalState<AddService> {
  Service _newService = Service();

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _autocompleteSatisfactionDegreeController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _inputFieldTitleController = TextEditingController();
  TextEditingController _inputFieldParticipantsController = TextEditingController();
  TextEditingController _inputFieldDurationController = TextEditingController();
  TextEditingController _inputFieldMoneyRaisedController = TextEditingController();
  TextEditingController _inputFieldServedPeopleController = TextEditingController();
  TextEditingController _inputFieldOtherAssociationsController = TextEditingController();
  TextEditingController _inputFieldDescriptionController = TextEditingController();

  List<SatisfactionDegree> _allSatisfactionDegrees;
  List<TypeService> _allTypes;
  List<CompetenceArea> _allAreas;


  @override
  void refreshState() {
    _allSatisfactionDegrees = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES));
    _allTypes = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_SERVICE));
    _allAreas = List.of(ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_AREAS));
  }

  @override
  Widget build(BuildContext context) {
    _dateTextController.text = _newService.date.toStringSlashed();
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
                    _newService.title = value;
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
                          _newService.date = date;
                          _dateTextController.text = date.toStringSlashed();
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
                    _newService.description = value;
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
                    _newService.city = suggestion;
                  },
                ),
              ),
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("money_raised"),
                  controller: _inputFieldMoneyRaisedController,
                  keyboardType: TextInputType.number,
                  onSubmit: (String value) {
                    _newService.moneyRaised = double.parse(value);
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
                    _newService.quantityParticipants = int.parse(value);
                  },
                ),
              ),
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("quantity_served_people"),
                  controller: _inputFieldServedPeopleController,
                  keyboardType: TextInputType.number,
                  onSubmit: (String value) {
                    _newService.quantityServedPeople = int.parse(value);
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
                    _newService.duration = int.parse(value);
                  },
                ),
              ),
              Flexible(
                child: InputAutocomplete(
                  labelText: AppLocalizations.of(context).translate("satisfaction_degree"),
                  controller: _autocompleteSatisfactionDegreeController,
                  onSuggestion: (String pattern) {
                    return _allSatisfactionDegrees;
                  },
                  onSelect: (suggestion) {
                    _autocompleteSatisfactionDegreeController.text = suggestion.toString();
                    _newService.satisfactionDegree = suggestion;
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
                        title: item.name,
                        value: item.selected,
                        onChanged: (bool x) {
                          setState(() {
                            item.selected = !item.selected;
                            if ( item.selected ) {
                              _newService.competenceAreasService.add(item);
                            }
                            else {
                              if ( _newService.competenceAreasService.contains(item) ) {
                                _newService.competenceAreasService.remove(item);
                              }
                            }
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
                          title: item.name,
                          value: item.selected,
                          onChanged: (bool x) {
                            setState(() {
                              item.selected = !item.selected;
                              if ( item.selected ) {
                                _newService.typesService.add(item);
                              }
                              else {
                                if ( _newService.typesService.contains(item) ) {
                                  _newService.typesService.remove(item);
                                }
                              }
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
                    _newService.otherAssociations = value;
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