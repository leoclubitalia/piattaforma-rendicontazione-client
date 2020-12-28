import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/buttons/StadiumButton.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:flutter/material.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/StringCapitalization.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpandableLogInButton extends StatefulWidget {
  final String textOuterButton;
  final Function onSubmit;


  ExpandableLogInButton({Key key, this.textOuterButton, this.onSubmit}) : super(key: key);

  @override
  _ExpandableLogInButton createState() => _ExpandableLogInButton(this.textOuterButton, this.onSubmit);
}


class _ExpandableLogInButton extends GlobalState<ExpandableLogInButton> with TickerProviderStateMixin {
  final String textOuterButton;
  final Function onSubmit;

  AnimationController _topAnimationController;
  AnimationController _bottomAnimationController;
  Animation<double> _topAnimation;
  Animation<double> _bottomAnimation;
  TextEditingController _inputFieldEmailController = TextEditingController();
  TextEditingController _inputFieldPasswordController = TextEditingController();


  _ExpandableLogInButton(this.textOuterButton, this.onSubmit);

  @override
  void initState() {
    super.initState();
    _topAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _topAnimationController.value = 1;
    _topAnimationController.addListener(() {
      setState(() {});
    });
    _bottomAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _bottomAnimationController.value = 0;
    _bottomAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    _topAnimation = CurvedAnimation(parent: _topAnimationController, curve: Curves.easeInOut,);
    _bottomAnimation = CurvedAnimation(parent: _bottomAnimationController, curve: Curves.easeInOut,);
    return Column(
      children: [
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: _topAnimation,
          child: Center(
            child: Column(
              children: [
                StadiumButton(
                  icon: Icons.people_rounded,
                  title: textOuterButton,
                  onPressed: () {
                    if (_bottomAnimationController.status == AnimationStatus.dismissed) {
                      _bottomAnimationController.forward();
                    }
                    if (_topAnimationController.status == AnimationStatus.completed) {
                      _topAnimationController.reverse();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: _bottomAnimation,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 300,
                  child: InputField(
                    labelText: AppLocalizations.of(context).translate("email"),
                    controller: _inputFieldEmailController,
                  ),
                ),
                Container(
                  width: 300,
                  child: InputField(
                    labelText: AppLocalizations.of(context).translate("password"),
                    controller: _inputFieldPasswordController,
                    isPassword: true,
                    onSubmit: (_) {
                      onSubmit(_inputFieldEmailController.text, _inputFieldPasswordController.text);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: StadiumButton(
                    icon: Icons.login,
                    title: AppLocalizations.of(context).translate("log_in"),
                    padding: 0,
                    onPressed: () {
                      onSubmit(_inputFieldEmailController.text, _inputFieldPasswordController.text);
                    },
                  ),
                ),
                Padding (
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: FlatButton(
                    minWidth: 100000,
                    color: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () async {
                      await launch(Constants.LINK_RESET_PASSWORD);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate("forgot_password").capitalize,
                      textAlign: TextAlign.center,
                      textScaleFactor: 0.9,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Theme.of(context).splashColor,
                      ),
                    ),
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
