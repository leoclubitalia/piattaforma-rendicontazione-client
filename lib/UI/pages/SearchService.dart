import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchService extends StatefulWidget {
  SearchService({Key key}) : super(key: key);


  @override
  _SearchService createState() => _SearchService();
}

class _SearchService extends GlobalState<SearchService> {

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 650 ? 4 : 2,
        children: List.generate(10, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }),
      ),
    );
  }


}