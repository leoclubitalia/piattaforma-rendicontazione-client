import 'package:flutter/material.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';


abstract class GlobalState<T extends StatefulWidget> extends State<T> {


  GlobalState () {
    refreshState();
  }

  @override
  void initState() {
    ModelFacade.sharedInstance.appState.addStateListener(_setState);
    super.initState();
  }

  @override
  void deactivate() {
    ModelFacade.sharedInstance.appState.removeStateListener(_setState);
    super.deactivate();
  }

  void _setState() {
    setState(() {
      refreshState();
    });
  }

  void refreshState();


}