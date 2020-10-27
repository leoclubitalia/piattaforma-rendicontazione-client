import 'package:flutter/material.dart';


class DeveloperTile extends StatelessWidget {
  final String name;
  final String imageName;

  const DeveloperTile({Key key, this.name, this.imageName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Padding(
          padding: EdgeInsets.all(15),
          child: Container(
              width: 130.0,
              height: 130.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(imageName)
                  )
              )
          ),
        ),
        Text(name)
      ],
    );
  }


}






