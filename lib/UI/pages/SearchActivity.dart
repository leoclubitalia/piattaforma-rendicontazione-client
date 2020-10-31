import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchActivity extends StatefulWidget {
  SearchActivity({Key key}) : super(key: key);


  @override
  _SearchActivity createState() => _SearchActivity();
}

class _SearchActivity extends GlobalState<SearchActivity> {

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Text('activity')
        ),
      )
    );
  }


}