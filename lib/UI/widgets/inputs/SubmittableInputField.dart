import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/tiles/ActivityTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SubmittableInputField extends StatefulWidget {
  final String label;
  final Function onSubmit;
  final TextInputType keyboardType;


  SubmittableInputField({Key key, this.label, this.onSubmit, this.keyboardType}) : super(key: key);

  @override
  _SubmittableInputField createState() => _SubmittableInputField(this.label, this.onSubmit, this.keyboardType);
}


class _SubmittableInputField extends GlobalState<SubmittableInputField> with SingleTickerProviderStateMixin {
  final String label;
  final Function onSubmit;
  final TextInputType keyboardType;

  AnimationController animationController;
  Animation<double> collapseAnimation;
  TextEditingController textEditingController = TextEditingController();


  _SubmittableInputField(this.label, this.onSubmit,  this.keyboardType);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    collapseAnimation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn,);
    return Column(
      children: [
        Text(
            label,
            style: LeoTitleStyle()
        ),
        InputField(
          textAlign: TextAlign.center,
          controller: textEditingController,
          keyboardType: keyboardType,
          multiline: false,
          onTap: () {
            if (animationController.status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          },
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: collapseAnimation,
          child: Column(
            children: [
              FlatButton(
                onPressed: () {
                  onSubmit(textEditingController.text);
                  if (animationController.status == AnimationStatus.completed) {
                    animationController.reverse();
                  }
                },
                child: Text("Salva"),//TODO
              ),
            ],
          ),
        ),
      ],
    );
  }


}
