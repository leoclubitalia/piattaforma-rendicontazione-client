import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/CircularCheckBoxTitle.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/ListDeepClone.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';


class AddService extends StatefulWidget {
  AddService({Key key}) : super(key: key);

  @override
  _AddService createState() => _AddService();
}

class _AddService extends GlobalState<AddService> {
  Service _newService = Service.newCreation();

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

  bool _isAdding = false;
  bool _firstLoad = true;


  @override
  void refreshState() {
    if ( _firstLoad ) {
      _allSatisfactionDegrees = (ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES) as List<SatisfactionDegree>).deepClone();
      _allTypes = (ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_SERVICE) as List<TypeService>).deepClone();
      _allAreas = (ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_AREAS) as List<CompetenceArea>).deepClone();
      _firstLoad = false;
    }
    Service justAdded = ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_JUST_ADDED_SERVICE);
    if ( _isAdding ) {
      _isAdding = false;
      if ( justAdded == null && ModelFacade.sharedInstance.appState.existsValue(Constants.STATE_MESSAGE) ) {
        showErrorDialog(context, AppLocalizations.of(context).translate(ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_MESSAGE)));
      }
      else {
        Navigator.pop(context);
        ModelFacade.sharedInstance.appState.addValue(Constants.STATE_JUST_ADDED, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateTextController.text = _newService.date.toStringSlashed();
    return Container(
      width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.2,
      child: _isAdding ?
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).buttonColor),
        ),
      ) :
      Column(
        children: [
          Row(
            children: [
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("title") + "*",
                  controller: _inputFieldTitleController,
                  onChanged: (String value) {
                    _newService.title = value;
                  },
                ),
              ),
              Flexible(
                child: InputButton(
                  text: AppLocalizations.of(context).translate("date") + "*",
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
                  labelText: AppLocalizations.of(context).translate("description") + "*",
                  controller: _inputFieldDescriptionController,
                  multiline: true,
                  onChanged: (String value) {
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
                  labelText: AppLocalizations.of(context).translate("city") + "*",
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
                child: InputAutocomplete(
                  labelText: AppLocalizations.of(context).translate("satisfaction_degree") + "*",
                  controller: _autocompleteSatisfactionDegreeController,
                  typeable: false,
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
          Row(
            children: [
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("quantity_participants"),
                  controller: _inputFieldParticipantsController,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    _newService.quantityParticipants = int.parse(value);
                  },
                ),
              ),
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("quantity_served_people"),
                  controller: _inputFieldServedPeopleController,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
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
                  onChanged: (String value) {
                    _newService.duration = int.parse(value);
                  },
                ),
              ),
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("money_or_material_collected"),
                  controller: _inputFieldMoneyRaisedController,
                  onChanged: (String value) {
                    _newService.moneyOrMaterialCollected = value;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      child: Text(
                        AppLocalizations.of(context).translate("areas").capitalize + "*:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _allAreas.length,
                        itemBuilder: (context, index) {
                          return CircularCheckBoxTitle(
                              title: _allAreas[index].name,
                              value: _allAreas[index].selected,
                              onChanged: (bool x) {
                                setState(() {
                                  _allAreas[index].selected = !_allAreas[index].selected;
                                  if ( _allAreas[index].selected ) {
                                    _newService.competenceAreasService.add(_allAreas[index]);
                                  }
                                  else {
                                    if ( _newService.competenceAreasService.contains(_allAreas[index]) ) {
                                      _newService.competenceAreasService.remove(_allAreas[index]);
                                    }
                                  }
                                });
                              }
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context).translate("if_other_in_description"),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: Text(
                    AppLocalizations.of(context).translate("type_service").capitalize + "*:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allTypes.length,
                    itemBuilder: (context, index) {
                      return CircularCheckBoxTitle(
                        title: _allTypes[index].name,
                        value: _allTypes[index].selected,
                        onChanged: (bool x) {
                          setState(() {
                            _allTypes[index].selected = !_allTypes[index].selected;
                            if ( _allTypes[index].selected ) {
                              _newService.typesService.add(_allTypes[index]);
                            }
                            else {
                              if ( _newService.typesService.contains(_allTypes[index]) ) {
                                _newService.typesService.remove(_allTypes[index]);
                              }
                            }
                          });
                        }
                      );
                    },
                  ),
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
                  onChanged: (String value) {
                    _newService.otherAssociations = value;
                  },
                ),
              ),
              CircularIconButton(
                onPressed: () async {
                  bool fieldNotSpecified = false;
                  String message = AppLocalizations.of(context).translate("these_field_are_missed") + "\n";
                  if ( _newService.title == null || _newService.title == "" ) {
                    message += "\n" + AppLocalizations.of(context).translate("title");
                    fieldNotSpecified = true;
                  }
                  if ( _newService.description == null || _newService.description == "" ) {
                    message += "\n" + AppLocalizations.of(context).translate("description");
                    fieldNotSpecified = true;
                  }
                  if ( _newService.date == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("date");
                    fieldNotSpecified = true;
                  }
                  if ( _newService.city == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("city");
                    fieldNotSpecified = true;
                  }
                  if ( _newService.satisfactionDegree == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("satisfaction_degree");
                    fieldNotSpecified = true;
                  }
                  if ( _newService.typesService.isEmpty ) {
                    message += "\n" + AppLocalizations.of(context).translate("types_service");
                    fieldNotSpecified = true;
                  }
                  if ( _newService.competenceAreasService.isEmpty ) {
                    message += "\n" + AppLocalizations.of(context).translate("areas");
                    fieldNotSpecified = true;
                  }
                  if ( fieldNotSpecified ) {
                    showErrorDialog(context, message);
                  }
                  else {
                    ModelFacade.sharedInstance.addService(_newService);
                    setState(() {
                      _isAdding = true;
                    });
                  }
                },
                icon: Icons.add_rounded,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                AppLocalizations.of(context).translate("fields_mandatory"),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showErrorDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => MessageDialog(
          titleText: AppLocalizations.of(context).translate("oops"),
          bodyText: text,
        ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoundedDialog(
        body: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).buttonColor),
        ),
      ),
    );
  }


}
