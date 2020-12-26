import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/AddOrEditActivity.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/MessageDialog.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/dialogs/RoundedDialog.dart';
import 'package:RendicontationPlatformLeo_Client/model/ModelFacade.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';


class ActivityTile extends StatefulWidget {
  ActivityTile({Key key, this.activity}) : super(key: key);

  final Activity activity;

  @override
  _ActivityTile createState() => _ActivityTile(activity);
}

class _ActivityTile extends GlobalState<ActivityTile> with SingleTickerProviderStateMixin {
  final Activity activity;

  AnimationController animationController;
  Animation<double> collapseAnimation;


  _ActivityTile(this.activity);

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
                        activity.title,
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
                              TextSpan(text: activity.club.name),
                              TextSpan(text: " "),
                              TextSpan(
                                text: AppLocalizations.of(context).translate("district"),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(text: " "),
                              TextSpan(text: activity.club.district.name),
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
                              text: activity.date.toStringSlashed(),
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
                            TextSpan(text: activity.city.name),
                          ],
                        ),
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
                                text: AppLocalizations.of(context).translate("quantity_participants")
                            ),
                            TextSpan(text: ": "),
                            TextSpan(
                              text: activity.quantityLeo.toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10)
                      ),
                      ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB) != null &&
                      ModelFacade.sharedInstance.appState.getValue(Constants.STATE_CLUB).id == activity.club.id ?
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
                                            bodyText: AppLocalizations.of(context).translate("info_edit_activity"),
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
                              body: AddOrEditActivity(
                                activity: activity,
                              ),
                            ),
                          );
                        },
                      ) :
                      Padding(
                          padding: EdgeInsets.all(5)
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
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).splashColor,
                                fontStyle: FontStyle.normal,
                              ),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context).translate("type_activity").capitalize
                                ),
                                TextSpan(text: ": "),
                                for( var item in activity.typesActivity )
                                  TextSpan(
                                    text: item.name + " ",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                activity.typesActivity == null || activity.typesActivity.length == 0 ?
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
                                    text: AppLocalizations.of(context).translate("satisfaction_degree").capitalize
                                ),
                                TextSpan(text: ": "),
                                TextSpan(
                                  text: activity.satisfactionDegree.name,
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
                                    text: AppLocalizations.of(context).translate("lions_participation").capitalize
                                ),
                                TextSpan(text: ": "),
                                TextSpan(
                                  text: activity.lionsParticipation ? AppLocalizations.of(context).translate("yes") : AppLocalizations.of(context).translate("no"),
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
                        activity.description,
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