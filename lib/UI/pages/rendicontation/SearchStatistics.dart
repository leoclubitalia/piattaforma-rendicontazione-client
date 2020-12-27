import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';


class SearchStatistics extends StatefulWidget {
  SearchStatistics({Key key}) : super(key: key);


  @override
  _SearchStatistics createState() => _SearchStatistics();
}

class _SearchStatistics extends GlobalState<SearchStatistics> {


  @override
  void initState() {
    //ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_SERVICE_RESULT);
    ModelFacade.sharedInstance.loadAllDistricts();
    ModelFacade.sharedInstance.loadAllClubs();
    super.initState();
  }

  @override
  void refreshState() {

  }

  @override
  void dispose() {
    super.dispose();
    //ModelFacade.sharedInstance.appState.removeValue(Constants.STATE_SEARCH_SERVICE_RESULT);
  }

  bool isCircularMoment() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(

      ),
    );
  }


}
