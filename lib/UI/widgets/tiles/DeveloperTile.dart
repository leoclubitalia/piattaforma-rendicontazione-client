import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';



class DeveloperTile extends StatelessWidget {
  final String name;
  final String imageName;
  final String mailToAddress;


  const DeveloperTile({Key key, this.name, this.imageName, this.mailToAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Padding(
          padding: EdgeInsets.all(15),
          child: InkWell(
            onTap: () async {
              final mailtoLink = Mailto(
                to: [mailToAddress],
                subject: "Message sent from MyLeo MD 108",
              );
              await launch("$mailtoLink");
            },
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
        ),
        Text(name)
      ],
    );
  }


}






