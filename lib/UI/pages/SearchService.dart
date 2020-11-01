import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/InputFiled.dart';
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
  DateTime _startDate = DateTime(2000, 1, 1);
  DateTime _endDate = DateTime.now();

  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();


  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    _startDateTextController.text = _startDate.day.toString() + "/" + _startDate.month.toString() + "/" + _startDate.year.toString();
    _endDateTextController.text = _endDate.day.toString() + "/" + _endDate.month.toString() + "/" + _endDate.year.toString();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 1 / 0.25,
          crossAxisCount: MediaQuery.of(context).size.width > 650 ? 4 : 2,
          children: [
            InputField(
              padding: 5,
              labelText: AppLocalizations.of(context).translate("title"),
              onSubmit: (String value) {
                _title = value;
              },
            ),
            InputField(
              padding: 5,
              labelText: AppLocalizations.of(context).translate("other_associations"),
              onSubmit: (String value) {
                _otherAssociations = value;
              },
            ),
            InputButton(
              padding: 5,
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
              padding: 5,
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
              padding: 5,
              labelText: AppLocalizations.of(context).translate("quantity_participants"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _quantityParticipants = int.parse(value);
              },
            ),
            InputField(
              padding: 5,
              labelText: AppLocalizations.of(context).translate("duration"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _duration = int.parse(value);
              },
            ),
            InputField(
              padding: 5,
              labelText: AppLocalizations.of(context).translate("min_money_raised"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _minMoneyRaised = int.parse(value);
              },
            ),
            InputField(
              padding: 5,
              labelText: AppLocalizations.of(context).translate("max_money_raised"),
              keyboardType: TextInputType.number,
              onSubmit: (String value) {
                _maxMoneyRaised = int.parse(value);
              },
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
      )
    );
  }


}