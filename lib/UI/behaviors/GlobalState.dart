import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/ErrorListener.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:flutter/material.dart';


abstract class GlobalState<T extends StatefulWidget> extends State<T> implements ErrorListener {
  SnackBar errorSnackBar;


  GlobalState () {
    refreshState();
  }

  @override
  void initState() {
    ModelFacade.sharedInstance.appState.addStateListener(_setState);
    ModelFacade.sharedInstance.delegate = this;
    super.initState();
  }

  @override
  void deactivate() {
    ModelFacade.sharedInstance.appState.removeStateListener(_setState);
    if ( ModelFacade.sharedInstance.delegate == this ) {
      ModelFacade.sharedInstance.delegate = null;
    }
    super.deactivate();
  }

  void _setState() {
    setState(() {
      refreshState();
    });
  }

  @override
  void errorGone() {}

  @override
  void errorOccurred(String message) {
    errorSnackBar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Row(
        children: [
          Icon(
            Icons.error_rounded,
            color: Theme.of(context).splashColor,
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Text(
            AppLocalizations.of(context).translate(message),
            style: TextStyle(
              color: Theme.of(context).splashColor,
            ),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
  }

  void refreshState();


}