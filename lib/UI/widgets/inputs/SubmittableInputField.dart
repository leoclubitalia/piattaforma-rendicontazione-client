import 'package:RendicontationPlatformLeo_Client/UI/aspects/LeoTextStyles.dart';
import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:RendicontationPlatformLeo_Client/UI/widgets/inputs/InputFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SubmittableInputField extends StatefulWidget {
  final String label;
  final String value;
  final Function onSubmit;
  final TextInputType keyboardType;


  SubmittableInputField({Key key, this.label, this.value, this.onSubmit, this.keyboardType}) : super(key: key);

  @override
  _SubmittableInputField createState() => _SubmittableInputField(this.label, this.value, this.onSubmit, this.keyboardType);
}


class _SubmittableInputField extends GlobalState<SubmittableInputField> with SingleTickerProviderStateMixin {
  String label;
  String value;
  Function onSubmit;
  TextInputType keyboardType;

  AnimationController animationController;
  Animation<double> collapseAnimation;
  TextEditingController textEditingController = TextEditingController();


  _SubmittableInputField(this.label, this.value, this.onSubmit,  this.keyboardType);

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
    textEditingController.text = value;
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                    ),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            value = textEditingController.text;
                          });
                          onSubmit(textEditingController.text);
                          if (animationController.status == AnimationStatus.completed) {
                            animationController.reverse();
                          }
                        },
                        icon: Icon(Icons.check, size: 15.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle
                    ),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            textEditingController.text = value;
                          });
                          if (animationController.status == AnimationStatus.completed) {
                            animationController.reverse();
                          }
                        },
                        icon: Icon(Icons.clear, size: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }


}
