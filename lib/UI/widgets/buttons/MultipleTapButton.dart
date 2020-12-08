import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:flutter/material.dart';


class MultipleTapButton extends StatefulWidget {
  final int taps;
  final Function onTaps;
  final Widget child;


  MultipleTapButton({Key key, this.taps, this.onTaps, this.child}) : super(key: key);

  @override
  _MultipleTapButton createState() => _MultipleTapButton(this.taps, this.onTaps, this.child);
}


class _MultipleTapButton extends GlobalState<MultipleTapButton> {
  final int taps;
  final Function onTaps;
  final Widget child;

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;


  _MultipleTapButton(this.taps, this.onTaps, this.child);

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int now = DateTime.now().millisecondsSinceEpoch;
        if ( now - lastTap < 1000 ) {
          consecutiveTaps ++;
          if ( consecutiveTaps > taps ){
            onTaps();
          }
        }
        else {
          consecutiveTaps = 0;
        }
        lastTap = now;
      },
      child: child,
    );
  }


}
