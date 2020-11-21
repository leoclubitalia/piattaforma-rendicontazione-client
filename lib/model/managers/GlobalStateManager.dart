import 'package:meta/meta.dart';


class GlobalStateManager {
  List<Function> delegatedFunctions = new List<Function>();


  void addStateListener(Function delegatedFunction) {
    delegatedFunctions.add(delegatedFunction);
  }

  void removeStateListener(Function delegatedFunction) {
    delegatedFunctions.remove(delegatedFunction);
  }

  void refreshStates() {
    for ( Function delegatedFunction in delegatedFunctions ) {
      delegatedFunction();
    }
  }


}