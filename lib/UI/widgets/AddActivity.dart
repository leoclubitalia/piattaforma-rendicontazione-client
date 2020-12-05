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
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/ListDeepClone.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';


class AddActivity extends StatefulWidget {
  AddActivity({Key key}) : super(key: key);

  @override
  _AddActivity createState() => _AddActivity();
}

class _AddActivity extends GlobalState<AddActivity> {
  Activity _newActivity = Activity.newCreation();

  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _autocompleteSatisfactionDegreeController = TextEditingController();
  TextEditingController _autocompleteCityController = TextEditingController();
  TextEditingController _inputFieldTitleController = TextEditingController();
  TextEditingController _inputFieldParticipantsController = TextEditingController();
  TextEditingController _inputFieldDescriptionController = TextEditingController();

  List<SatisfactionDegree> _allSatisfactionDegrees;
  List<TypeActivity> _allTypes;

  bool _isAdding = false;
  bool _firstLoad = true;


  @override
  void refreshState() {
    if ( _firstLoad ) {
      _allSatisfactionDegrees = (ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES) as List<SatisfactionDegree>).deepClone();
      _allTypes = (ModelFacade.sharedInstance.appState.getValue(Constants.STATE_ALL_TYPE_ACTIVITY) as List<TypeActivity>).deepClone();
      _firstLoad = false;
    }
    Activity justAdded = ModelFacade.sharedInstance.appState.getAndDestroyValue(Constants.STATE_JUST_ADDED_ACTIVITY);
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
    _dateTextController.text = _newActivity.date.toStringSlashed();
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
                  maxLength: 50,
                  controller: _inputFieldTitleController,
                  onChanged: (String value) {
                    _newActivity.title = value;
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
                        _newActivity.date = date;
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
                  maxLength: 500,
                  controller: _inputFieldDescriptionController,
                  multiline: true,
                  onChanged: (String value) {
                    _newActivity.description = value;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context).translate("quantity_participants") + "*",
                  controller: _inputFieldParticipantsController,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    _newActivity.quantityLeo = int.parse(value);
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
                    _newActivity.satisfactionDegree = suggestion;
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
                    AppLocalizations.of(context).translate("type_activity").capitalize + "*:",
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
                              _newActivity.typesActivity.add(_allTypes[index]);
                            }
                            else {
                              if ( _newActivity.typesActivity.contains(_allTypes[index]) ) {
                                _newActivity.typesActivity.remove(_allTypes[index]);
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
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  children: [
                    Container(
                      width: 166,
                      child: Text(
                        AppLocalizations.of(context).translate("lions_participation").capitalize + "*:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      child: Row(
                        children: [
                          CircularCheckBoxTitle(
                              title: AppLocalizations.of(context).translate("yes"),
                              value: _newActivity.lionsParticipation,
                              onChanged: ( bool x ) {
                                setState(() {
                                  _newActivity.lionsParticipation = !_newActivity.lionsParticipation;
                                });
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
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
                    _newActivity.city = suggestion;
                  },
                ),
              ),
              CircularIconButton(
                onPressed: () async {
                  bool fieldNotSpecified = false;
                  String message = AppLocalizations.of(context).translate("these_field_are_missed") + "\n";
                  if ( _newActivity.title == null || _newActivity.title == "" ) {
                    message += "\n" + AppLocalizations.of(context).translate("title");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.description == null || _newActivity.description == "" ) {
                    message += "\n" + AppLocalizations.of(context).translate("description");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.date == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("date");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.quantityLeo == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("quantity_participants");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.lionsParticipation == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("lions_participation");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.city == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("city");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.satisfactionDegree == null ) {
                    message += "\n" + AppLocalizations.of(context).translate("satisfaction_degree");
                    fieldNotSpecified = true;
                  }
                  if ( _newActivity.typesActivity.isEmpty ) {
                    message += "\n" + AppLocalizations.of(context).translate("types_activity");
                    fieldNotSpecified = true;
                  }
                  if ( fieldNotSpecified ) {
                    showErrorDialog(context, message);
                  }
                  else {
                    ModelFacade.sharedInstance.addActivity(_newActivity);
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
