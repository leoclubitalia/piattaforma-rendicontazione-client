import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/CircularIconButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputAutocomplete.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Statistics.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();
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
    _startDateTextController.text = _startDate.toStringSlashed();
    _endDateTextController.text = _endDate.toStringSlashed();
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
                    showResult(_searchResult),
                  ],
                ),
              ),
            ],
          ),
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
                            _startDateTextController.text = date.toStringSlashed();
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
                            _endDateTextController.text = date.toStringSlashed();
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.it
                        );
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
  }

  Widget showResult(Statistics searchResult) {
    return  Expanded(
      child: SingleChildScrollView(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),
             ),
             child: Padding(
               padding: EdgeInsets.all(10),
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                     child: Row(
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                           child: Icon(
                             UIConstants.ICON_MEMBERS,
                             size: 30,
                           ),
                         ),
                         Text(
                           AppLocalizations.of(context).translate("people").capitalize + ":",
                           style: LeoBigBoldTitleStyle(),
                         ),
                       ],
                     ),
                   ),
                   Row(
                     children: [
                       RichText(
                         textAlign: TextAlign.start,
                         text: TextSpan(
                           style: TextStyle(
                             fontSize: 17,
                             color: Theme.of(context).splashColor,
                             fontStyle: FontStyle.normal,
                           ),
                           children: [
                             TextSpan(
                               text: AppLocalizations.of(context).translate("members").capitalize + ": ",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             TextSpan(text: searchResult.members.toString()),
                             TextSpan(text: "\n"),
                             TextSpan(
                               text: AppLocalizations.of(context).translate("aspirants").capitalize + ": ",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             TextSpan(text: searchResult.aspirants.toString()),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),
             ),
             child: Padding(
               padding: EdgeInsets.all(10),
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                     child: Row(
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                           child: Icon(
                             UIConstants.ICON_SERVICE,
                             size: 30,
                           ),
                         ),
                         Text(
                           AppLocalizations.of(context).translate("service").capitalize + ":",
                           style: LeoBigBoldTitleStyle(),
                         ),
                       ],
                     ),
                   ),
                   Row(
                     children: [
                       RichText(
                         textAlign: TextAlign.start,
                         text: TextSpan(
                           style: TextStyle(
                             fontSize: 17,
                             color: Theme.of(context).splashColor,
                             fontStyle: FontStyle.normal,
                           ),
                           children: [
                             TextSpan(
                               text: AppLocalizations.of(context).translate("overall").capitalize + ": ",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             TextSpan(text: searchResult.quantityServices.toString()),
                             TextSpan(text: "\n\n"),
                             TextSpan(
                               text: AppLocalizations.of(context).translate("per_area").capitalize + ":",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             for( var report in searchResult.servicesReport )
                               TextSpan(
                                   text: "\n" + report.name.capitalize + ": " + report.value.toString()
                               ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),
             ),
             child: Padding(
               padding: EdgeInsets.all(10),
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                     child: Row(
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                           child: Icon(
                             UIConstants.ICON_ACTIVITY,
                             size: 30,
                           ),
                         ),
                         Text(
                           AppLocalizations.of(context).translate("activity").capitalize + ":",
                           style: LeoBigBoldTitleStyle(),
                         ),
                       ],
                     ),
                   ),
                   Row(
                     children: [
                       RichText(
                         textAlign: TextAlign.start,
                         text: TextSpan(
                           style: TextStyle(
                             fontSize: 17,
                             color: Theme.of(context).splashColor,
                             fontStyle: FontStyle.normal,
                           ),
                           children: [
                             TextSpan(
                               text: AppLocalizations.of(context).translate("overall").capitalize + ": ",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             TextSpan(text: searchResult.quantityActivities.toString()),
                             TextSpan(text: "\n\n"),
                             TextSpan(
                               text: AppLocalizations.of(context).translate("per_type").capitalize + ":",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             for( var report in searchResult.activitiesReport )
                               TextSpan(
                                   text: "\n" + report.name.capitalize + ": " + report.value.toString()
                               ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           ),
         ],
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


}
