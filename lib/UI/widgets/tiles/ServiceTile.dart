import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: AppLocalizations.of(context).translate("made_in_date")
                            ),
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
                                fontStyle: FontStyle.normal,
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
                          for( var item in service.competenceAreasService ) Text(item.name)
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
                                text: AppLocalizations.of(context).translate("served_People")
                            ),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.quantityServedPeople == null ? UIConstants.NOT_DEFINED_TEXT : service.quantityServedPeople.toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: AppLocalizations.of(context).translate("quantity_participants")
                            ),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.quantityParticipants == null ? UIConstants.NOT_DEFINED_TEXT : service.quantityParticipants.toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: AppLocalizations.of(context).translate("duration")
                            ),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: service.duration == null ? UIConstants.NOT_DEFINED_TEXT : service.duration.toString() + " h",
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
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
                                    text: AppLocalizations.of(context).translate("satisfaction_degree").capitalize
                                ),
                                TextSpan(text: ": "),
                                TextSpan(
                                  text: service.satisfactionDegree.name,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
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
                                    text: item.name + " ",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                service.typesService == null || service.typesService.length == 0 ?
                                TextSpan(
                                  text: AppLocalizations.of(context).translate("no_one").capitalize
                                ) :
                                TextSpan(
                                  text: ""
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
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
                                    text: AppLocalizations.of(context).translate("money_or_material_collected").capitalize
                                ),
                                TextSpan(text: ": "),
                                TextSpan(
                                  text: service.moneyOrMaterialCollected == null ? UIConstants.NOT_DEFINED_TEXT : service.moneyOrMaterialCollected,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
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
                                    text: AppLocalizations.of(context).translate("other_associations").capitalize
                                ),
                                TextSpan(text: ": "),
                                TextSpan(
                                  text: service.otherAssociations == null ? UIConstants.NOT_DEFINED_TEXT : service.otherAssociations,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        service.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }


}