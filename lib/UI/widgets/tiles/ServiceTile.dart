import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/DateFormatter.dart';
import 'package:flutter/material.dart';


class ServiceTile extends StatefulWidget {
  ServiceTile({Key key, this.service}) : super(key: key);

  final Service service;

  @override
  _ServiceTile createState() => _ServiceTile(service);
}

class _ServiceTile extends GlobalState<ServiceTile> with SingleTickerProviderStateMixin {
  final Service service;

  AnimationController animationController;
  Animation<double> collapseAnimation;


  _ServiceTile(this.service);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    animationController.addListener(() {
      setState( () {} );
    });
  }

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    collapseAnimation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn,);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (animationController.status == AnimationStatus.dismissed) {
            animationController.forward();
          } else if (animationController.status == AnimationStatus.completed) {
            animationController.reverse();
          }
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).splashColor,
                            ),
                            children: [
                              TextSpan(text: service.club.name),
                              TextSpan(text: " "),
                              TextSpan(
                                text: AppLocalizations.of(context).translate("district"),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(text: " "),
                              TextSpan(text: service.club.district.name),
                            ],
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).splashColor,
                            fontStyle: FontStyle.normal,
                          ),
                          children: [
                            TextSpan(
                                text: AppLocalizations.of(context).translate("made_in_date")),
                            TextSpan(text: " "),
                            TextSpan(
                              text: service.date.toStringSlashed(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: AppLocalizations.of(context).translate("in_place"),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: " "),
                            TextSpan(text: service.city.name),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("areas") + ":",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      service.competenceAreasService == null ?
                      Text(
                        AppLocalizations.of(context).translate("no_one") + "!",
                      ) :
                      Column(
                        children: <Widget>[
                          for( var item in service.competenceAreasService ) Text(item.title)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).splashColor,
                            fontStyle: FontStyle.normal,
                          ),
                          children: [
                            TextSpan(
                                text: AppLocalizations.of(context).translate("served_People")),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.quantityServedPeople.toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: AppLocalizations.of(context).translate("quantity_participants")),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.quantityParticipants.toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: AppLocalizations.of(context).translate("money_raised")),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.moneyRaised.toString() + " €",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: AppLocalizations.of(context).translate("duration")),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.duration.toString() + " h",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: collapseAnimation,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RichText(
                          textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).splashColor,
                                fontStyle: FontStyle.normal,
                              ),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context).translate("types_service")
                                ),
                                TextSpan(text: ": "),
                                for( var item in service.typesService )
                                  TextSpan(
                                    text: item.title + " ",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        service.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }


}





