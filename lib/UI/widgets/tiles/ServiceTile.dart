import 'package:RendicontationPlatformLeo_Client/UI/aspects/UIConstants.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/AddOrEditService.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
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
              !isSmallDevice() ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leftContent(),
                  rightContent(),
                ],
              ) :
              Stack(
                children: [
                  leftContent(),
                  rightContent(),
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
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).splashColor,
                                fontStyle: FontStyle.normal,
                              ),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context).translate("areas")
                                ),
                                TextSpan(text: ": "),
                                for( var item in service.competenceAreasService )
                                  TextSpan(
                                    text: item.name + " ",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                service.competenceAreasService == null || service.competenceAreasService.length == 0 ?
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
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).splashColor,
                                fontStyle: FontStyle.normal,
                              ),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context).translate("impact").capitalize
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
                                    text: AppLocalizations.of(context).translate("duration").capitalize
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
                    !isSmallDevice() ?
                    Container() :
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          showQuatities(TextAlign.start),
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

  Widget leftContent() {
    return Column(
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
    );
  }

  bool isSmallDevice() {
    return MediaQuery.of(context).size.width <= UIConstants.WIDTH_SMALL_DEVICE;
  }

  bool isOwner() {
    return ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB) != null &&
           ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB).id == service.club.id;
  }

  Widget rightContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isSmallDevice() ?
        Container() :
        showQuatities(TextAlign.end),
        isOwner() ?
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.edit_rounded),
              iconSize: 20,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RoundedDialog(
                    title: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context).translate("edit").capitalize,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => MessageDialog(
                                  titleText: AppLocalizations.of(context).translate("info").capitalize,
                                  bodyText: AppLocalizations.of(context).translate("info_edit_service"),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.info_outline,
                              size: 26.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: AddOrEditService(
                      service: service,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_rounded),
              iconSize: 20,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RoundedDialog(
                    title: Text(
                      AppLocalizations.of(context).translate("are_you_sure_delete_service").capitalize,
                      textAlign: TextAlign.center,
                    ),
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StadiumButton(
                          minWidth: 100,
                          title: AppLocalizations.of(context).translate("yes").capitalize,
                          icon: Icons.check,
                          onPressed: () {
                            Navigator.pop(context);
                            ModelFacade.sharedInstance.deleteService(service);
                          },
                        ),
                        StadiumButton(
                          minWidth: 100,
                          title: AppLocalizations.of(context).translate("no").capitalize,
                          icon: Icons.clear,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ) :
        Padding(
            padding: EdgeInsets.all(5)
        ),
      ],
    );
  }

  Widget showQuatities(TextAlign alignement) {
    return Column (
      children: [
        Container(
          width: 143,
          child: RichText(
            textAlign: alignement,
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).splashColor,
                fontStyle: FontStyle.normal,
              ),
              children: [
                TextSpan(
                    text: AppLocalizations.of(context).translate("served_People").capitalize
                ),
                TextSpan(text: ": "),
                TextSpan(
                  text: service.quantityServedPeople == null ? UIConstants.NOT_DEFINED_TEXT : service.quantityServedPeople.toString(),
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        alignement == TextAlign.end ?
        Container():
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        ),
        Container(
          width: 143,
          child: RichText(
            textAlign: alignement,
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).splashColor,
                fontStyle: FontStyle.normal,
              ),
              children: [
                TextSpan(
                    text: AppLocalizations.of(context).translate("quantity_participants").capitalize
                ),
                TextSpan(text: ": "),
                TextSpan(
                  text: service.quantityParticipants == null ? UIConstants.NOT_DEFINED_TEXT : service.quantityParticipants.toString(),
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}