import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';



class DeveloperTile extends StatelessWidget {
  final String name;
  final String imageName;
  final String instagram;
  final String facebook;
  final String email;


  const DeveloperTile({Key key, this.name, this.imageName, this.instagram, this.facebook, this.email}) : super(key: key);

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
        Text(name),
        Container(
          alignment: Alignment.center,
          width: 130.0,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              instagram == null ? Padding(padding: EdgeInsets.all(0)) :
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color:Colors.grey,
                ),
                onPressed: () async {
                    await launch(instagram);
                  }
              ),
              facebook == null ? Padding(padding: EdgeInsets.all(0)) :
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.facebookF,
                  color:Colors.grey,
                ),
                onPressed: () async {
                  await launch(facebook);
                }
              ),
              email == null ? Padding(padding: EdgeInsets.all(0)) :
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.envelope,
                  color:Colors.grey,
                ),
                onPressed: () async {
                  final mailtoLink = Mailto(
                    to: [email],
                    subject: "Message sent from MyLeo MD 108",
                  );
                  await launch("$mailtoLink");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


}






